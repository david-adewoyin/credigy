import 'package:credigy/commands/add_customer_command.dart';
import 'package:credigy/commands/add_inventory_command.dart';
import 'package:credigy/commands/cash_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class AddCashBottomSheet extends StatefulWidget {
  const AddCashBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddCashBottomSheet> createState() => _AddCashPageState();
}

class _AddCashPageState extends State<AddCashBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _amountController = TextEditingController();
  CurrentAccount _currentAccount = CurrentAccount.cash;

  @override
  void dispose() {
    _amountController.dispose();
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
                        "Add Money to business",
                        style: TextStyles.subtitle.boldest.withSize(20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Amount",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        hintText: "Enter Cash flow in amount",
                        label: const Text("Amount"),
                        validator: (value) {
                          if (value == null) {
                            return "enter a value";
                          }
                          if (value == "") {
                            return "enter a value";
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Account to add money to",
                        style: TextStyles.subtitle.boldest.withSize(20),
                      ),
                      DropdownButtonFormField<CurrentAccount>(
                        style: TextStyles.subtitleSm.withColor(Colors.black),
                        decoration: InputDecoration(
                          isCollapsed: false,
                          isDense: false,
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: false,
                          hintText: "Select Account to add cash to",
                          hintStyle: TextStyles.body,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey.shade500, width: 1),
                          ),
                        ),
                        value: _currentAccount,
                        items: [
                          DropdownMenuItem(
                              value: CurrentAccount.cash,
                              child: Text(
                                "Cash",
                                style: TextStyles.subtitleSm.regular,
                              )),
                          DropdownMenuItem(
                            value: CurrentAccount.bank,
                            child: Text("Bank",
                                style: TextStyles.subtitleSm.regular),
                          ),
                        ],
                        onChanged: (v) {
                          setState(() {
                            _currentAccount = v!;
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
                                  double amount =
                                      double.parse(_amountController.text);
                                  var res = await AddCashCommand().run(
                                    BusinessMoneyModel(
                                      amount: amount,
                                      date: DateTime.now(),
                                      account: _currentAccount,
                                      actionType: BusinessMoneyModelType.add,
                                    ),
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Money data has been added",
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
                                            "Unable to add data",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Add Money",
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
