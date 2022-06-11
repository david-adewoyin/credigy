import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/commands/add_supplier_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class AddSupplierBottomSheet extends StatefulWidget {
  const AddSupplierBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddSupplierBottomSheet> createState() => _AddSupplierPageState();
}

class _AddSupplierPageState extends State<AddSupplierBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _SupplierName = TextEditingController();
  final TextEditingController _SupplierPhone = TextEditingController();
  final TextEditingController _SupplierEmail = TextEditingController();
  final TextEditingController _SupplierAddress = TextEditingController();
  final TextEditingController _SupplierDescription = TextEditingController();

  @override
  void dispose() {
    _SupplierName.dispose();
    _SupplierAddress.dispose();
    _SupplierDescription.dispose();
    _SupplierEmail.dispose();
    _SupplierPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                        controller: _SupplierName,
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
                        controller: _SupplierEmail,
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
                        controller: _SupplierPhone,
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
                        controller: _SupplierAddress,
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
                        controller: _SupplierDescription,
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
                                  var c = await AddSupplierCommand().run(
                                    name: _SupplierName.text,
                                    phone: _SupplierPhone.text,
                                    email: _SupplierEmail.text,
                                    address: _SupplierAddress.text,
                                    desc: _SupplierDescription.text,
                                  );
                                  print(c.name);

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Supplier data has been created",
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
                                            "Unable to create supplier",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Add Supplier",
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
