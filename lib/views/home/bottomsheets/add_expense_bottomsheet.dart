import 'package:credigy/commands/add_supplier_command.dart';
import 'package:credigy/commands/add_transaction_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

final List<DropdownMenuItem<ExpenseType>> expenseType = [
  const DropdownMenuItem(
    value: ExpenseType.procurementCost,
    child: Text("Procurement Cost"),
  ),
  const DropdownMenuItem(
    value: ExpenseType.wages,
    child: Text("Wages"),
  ),
  const DropdownMenuItem(
    value: ExpenseType.rent,
    child: Text("Rent"),
  ),
  const DropdownMenuItem(
    value: ExpenseType.utilities,
    child: Text("Utilities"),
  ),
  const DropdownMenuItem(
    value: ExpenseType.bills,
    child: Text("Bills"),
  ),
  const DropdownMenuItem(
    value: ExpenseType.transportation,
    child: Text("Transportation"),
  ),
  const DropdownMenuItem(
    value: ExpenseType.others,
    child: Text("Others"),
  ),
];

class AddExpenseBottomSheet extends StatefulWidget {
  const AddExpenseBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddExpenseBottomSheet> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _expenseAmount = TextEditingController();
  PaymentMethod _paymentAccount = PaymentMethod.cash;
  ExpenseType? expenseTypeSelected;
  @override
  void dispose() {
    _expenseAmount.dispose();
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
                        "Add Expense",
                        style: TextStyles.subtitle.boldest.withSize(20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Expense Description",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<ExpenseType>(
                        validator: (value) {
                          if (value == null) {
                            return "enter a value";
                          }
                        },
                        items: expenseType,
                        onChanged: (value) {
                          expenseTypeSelected = value;
                        },
                        decoration: InputDecoration(
                          label: const Text("Expense Description"),
                          isCollapsed: false,
                          isDense: false,
                          contentPadding: const EdgeInsets.only(left: 20),
                          filled: false,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "expense description",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Expense Amount",
                        style: TextStyles.bodySm,
                      ),
                      const SizedBox(height: 10),
                      UiTextField(
                        controller: _expenseAmount,
                        keyboardType: TextInputType.number,
                        hintText: "Enter Amount spent on expense",
                        label: const Text("Expense amount"),
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
                          hintText: "Select Account Expense was paid from",
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
                                      double.parse(_expenseAmount.text);
                                  var expense = ExpenseTransactionModel(
                                    expenseDesc: expenseTypeSelected!,
                                    date: DateTime.now(),
                                    account: _paymentAccount,
                                    amount: amount,
                                  );
                                  var c =
                                      await AddExpenseTransactionCommand().run(
                                    expense: expense,
                                  );

                                  ScaffoldMessenger.maybeOf(context)!
                                      .showSnackBar(SnackBar(
                                          behavior: SnackBarBehavior.floating,
                                          content: Text(
                                            "Expenses has been created",
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
                                            "Unable to create expenses",
                                            style: TextStyles.body
                                                .withColor(Colors.white),
                                          )));
                                }
                              },
                              child: Text(
                                "Add Expenses",
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
