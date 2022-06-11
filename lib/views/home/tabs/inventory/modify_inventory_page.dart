import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/add_inventory_page.dart';
import 'package:flutter/material.dart';

class ModifyInventoryPage extends StatefulWidget {
  final InventoryModel product;
  const ModifyInventoryPage({Key? key, required this.product})
      : super(key: key);

  @override
  State<ModifyInventoryPage> createState() => _ModifyInventoryPageState();
}

class _ModifyInventoryPageState extends State<ModifyInventoryPage> {
  final _formKey = GlobalKey<FormState>();
  late MeasurementUnit? unit = widget.product.unit;

  late final TextEditingController _productName =
      TextEditingController(text: widget.product.productName);

  TextEditingController _quantityAvailable = TextEditingController();
  late final TextEditingController _sellingPrice =
      TextEditingController(text: widget.product.sellingPrice.toString());
  late final TextEditingController _costPrice =
      TextEditingController(text: widget.product.costPrice.toString());
  late bool _quantityIsActive;

  @override
  void initState() {
    if (widget.product.quantity != null) {
      _quantityAvailable =
          TextEditingController(text: widget.product.quantity.toString());
    }
    super.initState();
    _quantityIsActive = widget.product.quantity == null ? false : true;
  }

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
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        title: Text(
          "Update Item",
          style: TextStyles.subtitle.boldest.withSize(20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.all(10),
                                      primary: Colors.white,
                                      onPrimary: Colors.black),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyles.subtitleSm,
                                  )),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () async {
                                  var del = await DeleteInventoryCommand()
                                      .run(widget.product.id!);
                                  if (!del) {
                                    Navigator.maybeOf(context)!.pop();
                                    ScaffoldMessenger.maybeOf(context)!
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Unable to delete product",
                                              style: TextStyles.subtitleSm
                                                  .withColor(Colors.white),
                                            )));
                                  }
                                  Navigator.maybeOf(context)!.pop();
                                  Navigator.maybeOf(context)!.pop();

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "product has been successfully deleted",
                                            style: TextStyles.subtitleSm,
                                          )));
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyles.subtitleSm,
                                ),
                              ),
                            ],
                            title: Text("Delete Item"),
                            content:
                                Text("Are you sure you want to delete product"),
                          );
                        });
                  },
                  child: Text(
                    "Delete Item",
                    style: TextStyles.subtitleSm,
                  )),
            ],
          ),
          SizedBox(
            width: 30,
          )
        ],
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
                                  value: unit,
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
                                try {
                                  var res =
                                      await UpdateInventoryItemCommand().run(
                                    id: widget.product.id!,
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
                                            "Product has been updated",
                                            style: TextStyles.body,
                                          )));
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text(
                                "Update Item",
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
