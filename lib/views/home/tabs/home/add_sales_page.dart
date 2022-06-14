import 'package:credigy/commands/add_transaction_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class AddSalesTransaction extends StatefulWidget {
  const AddSalesTransaction({Key? key}) : super(key: key);

  @override
  State<AddSalesTransaction> createState() => _AddSalesTransactionState();
}

class _AddSalesTransactionState extends State<AddSalesTransaction> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  bool _productEntered = false;
  bool _hasQuantity = false;
  late PaymentType _paymentType = PaymentType.full;
  late PaymentMethod _paymentMethod = PaymentMethod.bank;

  final List<ProductTransactionModel> _selectedProducts = [];
  final List<Widget> _selectedProductsWidget = [];
  late ProductTransactionModel _selectedProduct;

  late final ScreenshotController _screenshotController =
      ScreenshotController();
  late CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    var appModel = context.read<AppModel>();
    var customers = appModel.customers();
    var inventory = appModel.inventory();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        title: Text(
          "Add Sales",
          style: TextStyles.subtitle.boldest.withSize(20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 1,
          margin: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer Name",
                      style: TextStyles.bodySm,
                    ),
                    const SizedBox(height: 10),
                    TypeAheadFormField<CustomerModel>(
                      validator: (value) {
                        if (value == "") {
                          return "enter a customer";
                        }
                      },
                      onSuggestionSelected: (value) {
                        _customerController.value =
                            TextEditingValue(text: value.name);
                        customer = value;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.name),
                        );
                      },
                      suggestionsCallback: (pattern) {
                        return customers
                            .where((element) => element.name.contains(pattern));
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        onSubmitted: (v) {},
                        controller: _customerController,
                        decoration: InputDecoration(
                          label: Text(
                            "Enter Customer name",
                            style: TextStyles.bodySm.sizePlus,
                          ),
                          isCollapsed: false,
                          isDense: false,
                          contentPadding:
                              const EdgeInsets.only(left: 20, top: 20),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Enter Customer Name",
                          hintStyle: TextStyles.bodySm.copyWith(
                            color: const Color(0xFFAEAEAE),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      "Add Product",
                      style: TextStyles.bodySm,
                    ),
                    const SizedBox(height: 10),
                    TypeAheadFormField<InventoryModel>(
                      validator: (value) {
                        if (_selectedProducts.isEmpty) {
                          return "select an available product";
                        }
                        if (value == "") {
                          return "enter a product";
                        }
                      },
                      onSuggestionSelected: (value) {
                        _productController.value =
                            TextEditingValue(text: value.productName);
                        setState(() {
                          _productEntered = true;
                          if (value.quantity != null) {
                            setState(() {
                              _hasQuantity = true;
                            });
                          } else {
                            setState(() {
                              _hasQuantity = false;
                            });
                          }
                        });
                        _selectedProduct = ProductTransactionModel(
                            name: value.productName,
                            id: value.id!,
                            costPrice: value.costPrice,
                            sellingPrice: value.sellingPrice,
                            quantity: value.quantity);
                        _selectedProducts.add(_selectedProduct);
                        if (_selectedProduct.quantity == null) {}
                        var key = UniqueKey();
                        var wid = ListTile(
                          key: key,
                          title: Text(
                            value.productName,
                            style: TextStyles.subtitleSm,
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _quantityController.clear();
                                _productController.clear();
                                _selectedProducts.removeWhere(
                                    (element) => element.id == value.id);
                                _selectedProductsWidget.removeWhere(
                                    (element) => element.key == key);
                              });
                            },
                          ),
                        );
                        _selectedProductsWidget.add(wid);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.productName),
                        );
                      },
                      suggestionsCallback: (pattern) {
                        List<int> e =
                            _selectedProducts.map((e) => e.id).toList();
                        return inventory
                            .where((element) =>
                                element.productName.contains(pattern))
                            .where((element) => element.quantity == null
                                ? true
                                : element.quantity! > 0
                                    ? true
                                    : false)
                            .where((el) => e.contains(el.id) == false);
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        textInputAction: TextInputAction.done,
                        controller: _productController,
                        decoration: InputDecoration(
                          label: Text(
                            "Enter Product name",
                            style: TextStyles.bodySm.sizePlus,
                          ),
                          isCollapsed: false,
                          isDense: false,
                          contentPadding:
                              const EdgeInsets.only(left: 20, top: 20),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Enter Product Name",
                          hintStyle: TextStyles.bodySm.copyWith(
                            color: const Color(0xFFAEAEAE),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    if (_productEntered && _hasQuantity) ...[
                      Text(
                        "Number of Quantity",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: UiTextField(
                          validator: (value) {
                            if (!_hasQuantity) return null;
                            if (value == "") {
                              return "enter quantity";
                            }
                            var q = int.parse(value!);
                            var available = inventory
                                .where((element) =>
                                    element.productName ==
                                    _selectedProduct.name)
                                .first
                                .quantity;
                            if (q > available!) {
                              return "available quantity is only $available";
                            }
                          },
                          controller: _quantityController,
                          onChange: (value) {
                            _selectedProducts.last.quantity = int.parse(value!);
                          },
                          onSubmit: (value) {
                            _selectedProducts.last.quantity = int.parse(value!);
                          },
                          hintText: "Number of Quantity",
                          keyboardType: TextInputType.number,
                          label: Text("Number of Quantity"),
                        ),
                      ),
                    ],
                    ..._selectedProductsWidget,
                    if (_productEntered && _hasQuantity) ...[
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _productController.clear();
                              _quantityController.clear();

                              var c = int.parse(_quantityController.text);
                              _selectedProduct.quantity = c;
                              _selectedProducts.add(_selectedProduct);
                              _hasQuantity = false;
                            });
                          },
                          child: const Text("Add More Product Item")),
                      const SizedBox(height: 10),
                    ],

                    // cash bank
                    // paid full, part none

                    // paid full, part none
                    Text(
                      "Payment Type",
                      style: TextStyles.bodySm,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<PaymentType>(
                      style: TextStyles.subtitleSm.withColor(Colors.black),
                      decoration: InputDecoration(
                        isCollapsed: false,
                        isDense: false,
                        contentPadding: const EdgeInsets.only(left: 20),
                        filled: false,
                        hintText: "Select Payment Type",
                        hintStyle: TextStyles.body,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade500, width: 1),
                        ),
                      ),
                      value: _paymentType,
                      items: [
                        DropdownMenuItem(
                            value: PaymentType.credit,
                            child: Text(
                              "Paid on Credit",
                              style: TextStyles.subtitleSm,
                            )),
                        DropdownMenuItem(
                            value: PaymentType.full,
                            child: Text("Paid in Full")),
                      ],
                      onChanged: (v) {
                        setState(() {
                          _paymentType = v!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),

                    Text(
                      "Payment Method",
                      style: TextStyles.bodySm,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<PaymentMethod>(
                      style: TextStyles.subtitleSm.withColor(Colors.black),
                      decoration: InputDecoration(
                        isCollapsed: false,
                        isDense: false,
                        contentPadding: const EdgeInsets.only(left: 20),
                        filled: false,
                        hintText: "Select Payment Method",
                        hintStyle: TextStyles.body,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.shade500, width: 1),
                        ),
                      ),
                      value: _paymentMethod,
                      items: [
                        DropdownMenuItem(
                            value: PaymentMethod.bank,
                            child: Text(
                              "Bank",
                              style: TextStyles.subtitleSm,
                            )),
                        DropdownMenuItem(
                            value: PaymentMethod.cash, child: Text("Cash")),
                      ],
                      onChanged: (v) {
                        setState(() {
                          _paymentMethod = v!;
                        });
                      },
                    ),
                    const SizedBox(height: 30),

                    Builder(builder: (context) {
                      return Container(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15)),
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              double totalAmount = 0;
                              for (var p in _selectedProducts) {
                                if (p.quantity != null) {
                                  double a = p.quantity! * p.sellingPrice;
                                  totalAmount = totalAmount + a;
                                } else {
                                  totalAmount = totalAmount + p.sellingPrice;
                                }
                              }
                              var sale = SalesTransactionModel(
                                date: DateTime.now(),
                                totalAmount: totalAmount,
                                customer: customer,
                                paymentMethod: _paymentMethod,
                                paymentType: _paymentType,
                                products: _selectedProducts,
                              );

                              try {
                                var res = AddSalesTransactionCommand()
                                    .run(saleModel: sale, customer: customer);
                                Navigator.maybeOf(context)!
                                    .push(MaterialPageRoute(builder: (context) {
                                  return InvoiceGenerator(
                                    customer: customer,
                                    sale: sale,
                                    screenshotController: _screenshotController,
                                  );
                                }));
                              } catch (e) {
                                ScaffoldMessenger.maybeOf(context)!
                                    .showSnackBar(SnackBar(
                                        behavior: SnackBarBehavior.fixed,
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "unable to add sale transaction",
                                          style: TextStyles.body
                                              .withColor(Colors.white),
                                        )));
                              }
                            },
                            child: const Text("Add Sales"),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InvoiceGenerator extends StatelessWidget {
  const InvoiceGenerator({
    Key? key,
    required this.sale,
    required ScreenshotController screenshotController,
    required this.customer,
  })  : _screenshotController = screenshotController,
        super(key: key);

  final SalesTransactionModel sale;
  final ScreenshotController _screenshotController;
  final CustomerModel customer;

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();

    return Scaffold(
      body: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          Screenshot(
              controller: _screenshotController,
              child: Invoice(sale: sale, customer: customer)),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 300,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Align(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    sale.paymentType == PaymentType.full
                        ? "Generate Recipt"
                        : "Generate Invoice",
                    style: TextStyles.subtitle,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Colors.pink.withOpacity(0.9),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10)),
                      onPressed: () async {
                        try {
                          var directory =
                              await getApplicationDocumentsDirectory();

                          if (await Permission.storage.request().isGranted) {
                            var res = await _screenshotController
                                .captureAndSave(directory.path);
                            var c = await _screenshotController.capture();

                            var d = await ImageGallerySaver.saveImage(c!);
                            ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text("Invoice created"),
                              ),
                            );
                            Navigator.pushNamedAndRemoveUntil(context,
                                LandingPage.routeName, (route) => false);
                            return;
                          } else if (await Permission.storage
                              .request()
                              .isPermanentlyDenied) {
                            await openAppSettings();
                            var res = await _screenshotController
                                .captureAndSave(directory.path);
                            var c = await _screenshotController.capture();

                            var d = await ImageGallerySaver.saveImage(c!);
                            ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text("Invoice created"),
                              ),
                            );
                            Navigator.pushNamedAndRemoveUntil(context,
                                LandingPage.routeName, (route) => false);
                            return;
                          } else if (await Permission.storage
                              .request()
                              .isDenied) {}

                          ScaffoldMessenger.maybeOf(context)!
                              .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "Unable to create invoice",
                                    style:
                                        TextStyles.body.withColor(Colors.white),
                                  )));
                          Navigator.pushNamedAndRemoveUntil(
                              context, LandingPage.routeName, (route) => false);
                        } catch (e) {
                          ScaffoldMessenger.maybeOf(context)!
                              .showSnackBar(SnackBar(
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    "Unable to create invoice",
                                    style:
                                        TextStyles.body.withColor(Colors.white),
                                  )));
                        }

                        /*   Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          LandingPage
                                                              .routeName,
                                                          (route) => false); */
                      },
                      child: Text(
                          sale.paymentType == PaymentType.full
                              ? "Generate Receipt"
                              : "Generate Invoice",
                          style: TextStyles.subtitleSm)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Invoice extends StatelessWidget {
  final SalesTransactionModel sale;
  final CustomerModel customer;
  final _currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

  Invoice({Key? key, required this.sale, required this.customer})
      : super(key: key);

  buildRow(ProductTransactionModel product) {
    var amt = product.sellingPrice;
    if (product.quantity != null) {
      amt = product.quantity! * product.sellingPrice;
    }
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(product.name),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              text: _currency,
              style: TextStyles.moneyBody,
              children: [
                TextSpan(
                  text: "${amt}",
                  style: TextStyles.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    String _currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;
    var format = DateFormat.yMMMEd();

    var buss = appModel.getBusinessUser();
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
      child: ListView(
        shrinkWrap: true,
        children: [
          SafeArea(
            child: Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                            SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text("Data added")));
                        Navigator.pushNamedAndRemoveUntil(
                            context, LandingPage.routeName, (route) => false);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.pink,
                      )),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        sale.paymentType == PaymentType.credit
                            ? "Invoice"
                            : "Receipt",
                        style: TextStyles.h5.boldest,
                      ),
                      Text(format.format(DateTime.now())),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(buss.businessName, style: TextStyles.body.bold),
                SizedBox(height: 5),
                Text(buss.businessAddress, style: TextStyles.body),
                SizedBox(height: 5),
                Text(buss.email, style: TextStyles.body),
                SizedBox(height: 5),
                Text(buss.phone, style: TextStyles.body),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text(
            "Bill To",
            style: TextStyles.subtitle,
          ),
          SizedBox(height: 10),
          Text(customer.name, style: TextStyles.body),
          if (customer.address != null)
            Text("${customer.address}", style: TextStyles.body),
          if (customer.email != null)
            Text("${customer.email}", style: TextStyles.body),
          if (customer.phone != null)
            Text("${customer.phone}", style: TextStyles.body),
          SizedBox(height: 30),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            border: TableBorder(
                right: BorderSide(color: Colors.pink),
                left: BorderSide(color: Colors.pink),
                verticalInside: BorderSide(color: Colors.blue),
                top: BorderSide(color: Colors.pink),
                horizontalInside:
                    BorderSide(color: Colors.pink.withOpacity(0.2)),
                bottom: BorderSide(color: Colors.pink)),
            children: [
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Description"),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.all(8.0),
                    child: Text("Amount"),
                  ),
                ],
              ),
              for (var p in sale.products) ...[
                buildRow(p),
              ],
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Text(
                "Total: ",
                style: TextStyles.subtitleSm,
              ),
              SizedBox(width: 15),
              Text.rich(
                TextSpan(
                  text: _currency,
                  style: TextStyles.moneyBody,
                  children: [
                    TextSpan(
                      text: "${sale.totalAmount}",
                      style: TextStyles.subtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
              child: Text("Thank you for your business",
                  style: TextStyles.subtitle))
        ],
      ),
    );
  }
}
