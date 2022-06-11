import 'package:credigy/commands/add_customer_command.dart';
import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class AddCustomerBottomSheet extends StatefulWidget {
  const AddCustomerBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddCustomerBottomSheet> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _customerPhone = TextEditingController();
  final TextEditingController _customerEmail = TextEditingController();
  final TextEditingController _customerAddress = TextEditingController();
  final TextEditingController _customerDescription = TextEditingController();

  @override
  void dispose() {
    _customerName.dispose();
    _customerAddress.dispose();
    _customerDescription.dispose();
    _customerEmail.dispose();
    _customerPhone.dispose();
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
                        "Add Customer",
                        style: TextStyles.subtitle.boldest.withSize(20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Customer Name",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _customerName,
                        hintText: "Enter Customer Name",
                        label: const Text("Customer Name"),
                        validator: (value) {
                          if (value == null) {
                            return "enter a value";
                          }
                          if (value.length < 3) {
                            return "Namelength must be more than 3";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Customer Email",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _customerEmail,
                        keyboardType: TextInputType.emailAddress,
                        hintText: "Enter Customer Email",
                        label: const Text("Customer Email"),
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
                        "Customer Phone",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _customerPhone,
                        keyboardType: TextInputType.phone,
                        hintText: "Enter Customer Phone",
                        label: const Text("Customer Phone"),
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
                        "Customer Address",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _customerAddress,
                        keyboardType: TextInputType.streetAddress,
                        hintText: "Enter Customer Address",
                        label: const Text("Customer Address"),
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
                        "Customer Description",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextBoxField(
                        controller: _customerDescription,
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
                                  var res = await AddCustomerCommand().run(
                                    name: _customerName.text,
                                    email: _customerEmail.text,
                                    phone: _customerPhone.text,
                                    address: _customerAddress.text,
                                    desc: _customerDescription.text,
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Customer data has been created",
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
                                            "Unable to create customer",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Add Customer",
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
