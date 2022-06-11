import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/commands/add_customer_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/inventory_tab.dart';
import 'package:credigy/views/home/landing_page.dart';
import 'package:flutter/material.dart';

class ModifyCustomerPage extends StatefulWidget {
  final CustomerModel Customer;
  const ModifyCustomerPage({Key? key, required this.Customer})
      : super(key: key);

  @override
  State<ModifyCustomerPage> createState() => _ModifyCustomerPageState();
}

class _ModifyCustomerPageState extends State<ModifyCustomerPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _CustomerName =
      TextEditingController(text: widget.Customer.name);
  late final TextEditingController _CustomerAddress =
      TextEditingController(text: widget.Customer.address);
  late final TextEditingController _CustomerEmail =
      TextEditingController(text: widget.Customer.email);
  late final TextEditingController _CustomerPhone =
      TextEditingController(text: widget.Customer.phone);
  late final TextEditingController _CustomerDescription =
      TextEditingController(text: widget.Customer.description);

  @override
  void dispose() {
    _CustomerName.dispose();
    _CustomerAddress.dispose();
    _CustomerDescription.dispose();
    _CustomerEmail.dispose();
    _CustomerPhone.dispose();
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
          "Update Customer",
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
                                  var del = await DeleteCustomerCommand()
                                      .run(widget.Customer.id!);
                                  if (!del) {
                                    Navigator.maybeOf(context)!.pop();
                                    ScaffoldMessenger.maybeOf(context)!
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.red,
                                            behavior: SnackBarBehavior.floating,
                                            content: Text(
                                              "Unable to delete Customer",
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
                                            "Customer has been successfully deleted",
                                            style: TextStyles.subtitleSm,
                                          )));
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyles.subtitleSm,
                                ),
                              ),
                            ],
                            title: Text("Delete Customer"),
                            content: Text(
                                "Are you sure you want to delete Customer details"),
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
                        controller: _CustomerName,
                        hintText: "Enter Customer Name",
                        label: const Text("Customer Name"),
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
                        "Customer Email",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _CustomerEmail,
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
                        controller: _CustomerPhone,
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
                        controller: _CustomerAddress,
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
                        controller: _CustomerDescription,
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
                                  var c = await UpdateCustomerCommand().run(
                                    id: widget.Customer.id!,
                                    name: _CustomerName.text,
                                    phone: _CustomerPhone.text,
                                    email: _CustomerEmail.text,
                                    address: _CustomerAddress.text,
                                    desc: _CustomerDescription.text,
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Customer data has been updated",
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
                                            "Unable to update Customer",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Update Customer Details",
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
