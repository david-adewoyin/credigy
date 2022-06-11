import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/commands/add_supplier_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/supplier_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/inventory_tab.dart';
import 'package:credigy/views/home/landing_page.dart';
import 'package:flutter/material.dart';

class ModifySupplierPage extends StatefulWidget {
  final SupplierModel supplier;
  const ModifySupplierPage({Key? key, required this.supplier})
      : super(key: key);

  @override
  State<ModifySupplierPage> createState() => _ModifySupplierPageState();
}

class _ModifySupplierPageState extends State<ModifySupplierPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _supplierName =
      TextEditingController(text: widget.supplier.name);
  late final TextEditingController _supplierAddress =
      TextEditingController(text: widget.supplier.address);
  late final TextEditingController _supplierEmail =
      TextEditingController(text: widget.supplier.email);
  late final TextEditingController _supplierPhone =
      TextEditingController(text: widget.supplier.phone);
  late final TextEditingController _supplierDescription =
      TextEditingController(text: widget.supplier.description);

  @override
  void dispose() {
    _supplierName.dispose();
    _supplierAddress.dispose();
    _supplierDescription.dispose();
    _supplierEmail.dispose();
    _supplierPhone.dispose();
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
          "Update Supplier",
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
                                  var del = await DeleteSupplierCommand()
                                      .run(widget.supplier.id!);
                                  if (!del) {
                                    Navigator.maybeOf(context)!.pop();
                                    ScaffoldMessenger.maybeOf(context)!
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Unable to delete supplier",
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
                                            "supplier has been successfully deleted",
                                            style: TextStyles.subtitleSm,
                                          )));
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyles.subtitleSm,
                                ),
                              ),
                            ],
                            title: Text("Delete Supplier"),
                            content: Text(
                                "Are you sure you want to delete supplier details"),
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
        margin: const EdgeInsets.only(top: 50),
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
                        "Add Supplier",
                        style: TextStyles.subtitle.boldest.withSize(20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Supplier Name",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _supplierName,
                        hintText: "Enter Supplier Name",
                        label: const Text("Supplier Name"),
                        validator: (value) {
                          if (value == null) {
                            return "enter a value";
                          }
                          if (value.length < 3) {
                            return "Name length must be more than 3";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Supplier Email",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _supplierEmail,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter Supplier Email",
                        label: const Text("Supplier Email"),
                        //TODO fix validator for email
                        validator: (value) {
                          if (value == "") {
                            return null;
                          }
                          if (value!.length < 3) {
                            return "Email length must be more than 3";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Supplier Phone",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _supplierPhone,
                        keyboardType: TextInputType.phone,
                        hintText: "Enter Supplier Phone",
                        label: const Text("Supplier Phone"),
                        validator: (value) {
                          if (value == "") {
                            return null;
                          }
                          if (value!.length < 10) {
                            return "Phone length must be more than 10";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Supplier Address",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _supplierAddress,
                        keyboardType: TextInputType.streetAddress,
                        hintText: "Enter Supplier Address",
                        label: const Text("Supplier Address"),
                        validator: (value) {
                          if (value == "") {
                            return null;
                          }
                          if (value!.length < 3) {
                            return "Address length must be more than 3";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Supplier Description",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextBoxField(
                        controller: _supplierDescription,
                        hintText: "Enter Description",
                        label: const Text("Description"),
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
                                  var c = await UpdateSupplierCommand().run(
                                    id: widget.supplier.id!,
                                    name: _supplierName.text,
                                    phone: _supplierPhone.text,
                                    email: _supplierEmail.text,
                                    address: _supplierAddress.text,
                                    desc: _supplierDescription.text,
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Supplier data has been updated",
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
                                            "Unable to update supplier",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Update Supplier Details",
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
