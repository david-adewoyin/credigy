import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final List<DropdownMenuItem<MeasurementUnit>> measurementUnit = [
  const DropdownMenuItem(
    value: MeasurementUnit.kg,
    child: Text("Kg"),
  ),
  const DropdownMenuItem(
    value: MeasurementUnit.bag,
    child: Text("Bag"),
  ),
  const DropdownMenuItem(
    value: MeasurementUnit.box,
    child: Text("Box"),
  ),
  const DropdownMenuItem(
    value: MeasurementUnit.crate,
    child: Text("Crate"),
  ),
  const DropdownMenuItem(
    value: MeasurementUnit.none,
    child: Text("None"),
  ),
];

class AddInventoryPage extends StatefulWidget {
  const AddInventoryPage({Key? key}) : super(key: key);

  @override
  State<AddInventoryPage> createState() => _AddInventoryPageState();
}

class _AddInventoryPageState extends State<AddInventoryPage> {
  final _formKey = GlobalKey<FormState>();
  MeasurementUnit? unit = MeasurementUnit.none;

  final TextEditingController _productName = TextEditingController();
  final TextEditingController _quantityAvailable = TextEditingController();
  final TextEditingController _sellingPrice = TextEditingController();
  final TextEditingController _costPrice = TextEditingController();

  bool _quantityIsActive = true;

  @override
  void dispose() {
    _productName.dispose();
    _quantityAvailable.dispose();
    _sellingPrice.dispose();
    _costPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        title: Text(
          "Add Item",
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
          child: FocusScope(
            canRequestFocus: true,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _productName,
                        hintText: "Enter Product Name",
                        label: const Text("Enter Product Name"),
                        validator: (value) {
                          if (value == null) {
                            return "enter a value";
                          }
                          if (value.length < 3) {
                            return "Product length must be more than 3";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Unit of measurement",
                                  style: TextStyles.bodySm,
                                ),
                                const SizedBox(height: 10),
                                DropdownButtonFormField<MeasurementUnit>(
                                  validator: (value) {
                                    if (value == null) {
                                      return "enter a value";
                                    }
                                  },
                                  items: measurementUnit,
                                  onChanged: (value) {
                                    unit = value;
                                  },
                                  decoration: InputDecoration(
                                    label: const Text("Unit of Measurement"),
                                    isCollapsed: false,
                                    isDense: false,
                                    contentPadding:
                                        const EdgeInsets.only(left: 20),
                                    filled: false,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    hintText: "unit of measurement",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade100),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        value: _quantityIsActive,
                        title: Text(
                          "Turn off quanitity",
                          style: TextStyles.bodySm,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _quantityIsActive = value;
                          });
                        },
                      ),
                      if (_quantityIsActive) ...[
                        const SizedBox(height: 10),
                        Text(
                          "Quantity in Stock",
                          style: TextStyles.bodySm,
                        ),
                        const SizedBox(height: 10),
                        UiTextField(
                          hintText: "Enter Number of Quantity",
                          controller: _quantityAvailable,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == "") {
                              return "enter a number";
                            }
                            if (int.tryParse(value!) == null)
                              return "enter a number";
                          },
                          label: const Text("Enter Number of Quantity"),
                        ),
                      ],
                      const SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cost Price",
                                  style: TextStyles.bodySm,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: UiTextField(
                                    validator: (value) {
                                      if (value == "") {
                                        return "enter a value";
                                      }
                                      if (double.tryParse(value!) == null)
                                        return "enter a number";
                                    },
                                    controller: _costPrice,
                                    hintText: "Enter Cost Price",
                                    keyboardType: TextInputType.number,
                                    label: const Text("Enter Cost Price"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Selling Price",
                                  style: TextStyles.bodySm,
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: UiTextField(
                                    validator: (value) {
                                      if (value == "") {
                                        return "enter a value";
                                      }
                                      if (double.tryParse(value!) == null)
                                        return "enter a number";
                                    },
                                    controller: _sellingPrice,
                                    keyboardType: TextInputType.number,
                                    hintText: "Enter Selling Price",
                                    label: const Text("Enter Selling Price"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Flexible(
                        flex: 2,
                        child: Container(
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
                                if (appModel
                                    .inventory()
                                    .where((element) =>
                                        element.productName ==
                                        _productName.text)
                                    .isNotEmpty) {
                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Product already exist",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                  return;
                                }

                                try {
                                  var res = await AddInventoryCommand().run(
                                    productName: _productName.text,
                                    measurementUnit: unit!,
                                    costPrice: double.parse(_costPrice.text),
                                    quantity: _quantityIsActive
                                        ? int.parse(_quantityAvailable.text)
                                        : null,
                                    sellingPrice:
                                        double.parse(_sellingPrice.text),
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Product has been created",
                                            style: TextStyles.body,
                                          )));
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.red,
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Unable to create  product",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Add Item",
                                style: TextStyles.body,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
