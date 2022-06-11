import 'package:credigy/commands/add_supplier_command.dart';
import 'package:credigy/commands/add_transaction_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class AddPurchaseBottomSheet extends StatefulWidget {
  const AddPurchaseBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddPurchaseBottomSheet> createState() => _AddPurchasePageState();
}

class _AddPurchasePageState extends State<AddPurchaseBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _purchaseName = TextEditingController();
  final TextEditingController _purchaseAmount = TextEditingController();
  PaymentMethod _paymentAccount = PaymentMethod.cash;
  @override
  void dispose() {
    _purchaseName.dispose();
    _purchaseAmount.dispose();
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
                        "Add Purchase",
                        style: TextStyles.subtitle.boldest.withSize(20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Purchase Description",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _purchaseName,
                        hintText: "Enter Purchase description",
                        label: const Text("Purchase description"),
                        validator: (value) {
                          if (value == null) {
                            return "enter a value";
                          }
                          if (value.length < 3) {
                            return "description length must be more than 3";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Purchase Amount",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _purchaseAmount,
                        keyboardType: TextInputType.number,
                        hintText: "Enter Amount spent on Purchase",
                        label: const Text("purchase amount"),
                        validator: (value) {
                          if (value == "") {
                            return null;
                          }
                          if (double.tryParse(value!) == null)
                            return "enter a number";
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Paid from Account",
                        style: TextStyles.bodySm,
                      ),
                      DropdownButtonFormField<PaymentMethod>(
                        style: TextStyles.subtitleSm.withColor(Colors.black),
                        decoration: InputDecoration(
                          isCollapsed: false,
                          isDense: false,
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: false,
                          hintText: "Select Account Purchase was paid from",
                          hintStyle: TextStyles.body,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 1),
                          ),
                        ),
                        value: _paymentAccount,
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
                            _paymentAccount = v!;
                          });
                        },
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
                                  var amount =
                                      double.parse(_purchaseAmount.text);
                                  var purchase = PurchaseTransactionModel(
                                    purchaseName: _purchaseName.text,
                                    date: DateTime.now(),
                                    account: _paymentAccount,
                                    amount: amount,
                                  );
                                  var c =
                                      await AddPurchaseTransactionCommand().run(
                                    purchase: purchase,
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Purchases has been created",
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
                                            "Unable to create Purchases",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Add Purchases",
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
