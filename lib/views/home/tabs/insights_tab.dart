import 'package:credigy/commands/cash_command.dart';
import 'package:credigy/commands/insight_command.dart';
import 'package:credigy/components/custom_card_widget.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

var _numberFormat = NumberFormat.compact();

class InsightTab extends StatelessWidget {
  const InsightTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Insights",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            InsightWidget(),
            SizedBox(height: 3),
            /*  Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(children: [
                Expanded(
                  child: Card(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(Icons.money,
                                size: 26,
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Cash",
                            style: TextStyles.subtitleSm.withSize(16).boldest,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "\$5400",
                            style: TextStyles.subtitle.withSize(18).bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2),
                Expanded(
                  child: Card(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(Icons.money,
                                size: 26,
                                color: Colors.deepPurple.withOpacity(0.7)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Cash",
                            style: TextStyles.subtitleSm.withSize(16).boldest,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "\$5400",
                            style: TextStyles.subtitle.withSize(18).bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            */
            SizedBox(height: 2),
            /*   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Expenses Categories",
                        style: TextStyles.subtitleSm,
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.purpleAccent.withOpacity(0.2),
                              ),
                              child: Text(
                                "C",
                                style: TextStyles.subtitleSm,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Transfer", style: TextStyles.subtitleSm),
                            Spacer(),
                            Text("-\$15", style: TextStyles.subtitleSm),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.purpleAccent.withOpacity(0.2),
                              ),
                              child: Text(
                                "C",
                                style: TextStyles.subtitleSm,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Transfer", style: TextStyles.subtitleSm),
                            Spacer(),
                            Text("-\$15", style: TextStyles.subtitleSm),
                            SizedBox(width: 20),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 18, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.purpleAccent.withOpacity(0.2),
                              ),
                              child: Text(
                                "C",
                                style: TextStyles.subtitleSm,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Transfer", style: TextStyles.subtitleSm),
                            Spacer(),
                            Text("-\$15", style: TextStyles.subtitleSm),
                            SizedBox(width: 20),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
           */ /*   Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        "Invoices",
                        style: TextStyles.subtitleSm,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade100,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 20),
                          title: Row(children: [
                            Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.payment_rounded,
                                  size: 16,
                                  color: Colors.green,
                                )),
                            SizedBox(width: 14),
                            Text(
                              "Outstanding",
                              style: TextStyles.subtitleSm,
                            ),
                            Spacer(),
                            Text(
                              "  \$ 5000.00",
                              style: TextStyles.subtitle,
                            ),
                          ],),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade100,
                            ),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 5, right: 20),
                          title: Row(children: [
                            Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.payment_rounded,
                                  size: 16,
                                  color: Colors.green,
                                )),
                            SizedBox(width: 14),
                            Text(
                              "Outstanding",
                              style: TextStyles.subtitleSm,
                            ),
                            Spacer(),
                            Text(
                              "  \$ 5000.00",
                              style: TextStyles.subtitle,
                            ),
                          ],),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
           */
          ],
        ),
      ),
    );
  }
}

class InsightWidget extends StatelessWidget {
  const InsightWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    var totalIncome = appModel.getTotalIncome();
    var totalExpense = appModel.getTotalExpenses();

    late Color background;
    late String symbol;
    String currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;
    bool positive = totalIncome > totalExpense;
    if (positive) {
      symbol = "+";
      background = Colors.green;
    } else {
      symbol = "-";
      background = Colors.red;
    }

    return Builder(builder: (context) {
      return Card(
        elevation: 1,
        shape: RoundedRectangleBorder(),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //   CustomCardWidget(heading: "Profit/Loss"),
            CustomDropDown(appModel: appModel),
            Divider(
              color: Colors.grey.shade300,
            ),
            CurrentAccountWidget(),
          ],
        ),
      );
    });
  }
}

class CurrentAccountWidget extends StatelessWidget {
  final String _currency =
      NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

  CurrentAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    var cash = _numberFormat.format(appModel.getTotalCash());
    var bank = _numberFormat.format(appModel.getTotalBank());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.money,
                          size: 26, color: Colors.deepPurple.withOpacity(0.7)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Cash",
                      style: TextStyles.subtitleSm.withSize(16).boldest,
                    ),
                    SizedBox(height: 5),
                    Text.rich(
                      TextSpan(
                        text: _currency,
                        style: TextStyles.moneyBody,
                        children: [
                          TextSpan(
                            text: cash,
                            style: TextStyles.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 2),
          Expanded(
            child: Card(
              elevation: 0,
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.money,
                          size: 26, color: Colors.deepPurple.withOpacity(0.7)),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Bank",
                      style: TextStyles.subtitleSm.withSize(16).boldest,
                    ),
                    SizedBox(height: 5),
                    Text.rich(
                      TextSpan(
                        text: _currency,
                        style: TextStyles.moneyBody,
                        children: [
                          TextSpan(
                            text: bank,
                            style: TextStyles.subtitle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropDown extends StatefulWidget {
  final AppModel appModel;
  CustomDropDown({Key? key, required this.appModel}) : super(key: key);
  late var totalIncome = appModel.getTotalIncome();
  late var totalExpense = appModel.getTotalExpenses();
  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    late Color background;
    var gross = _numberFormat.format(widget.totalIncome - widget.totalExpense);
    var income = _numberFormat.format(widget.totalIncome);
    var expense = _numberFormat.format(widget.totalExpense);

    String currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;
    bool positive = widget.totalIncome > widget.totalExpense;
    if (positive) {
      background = Colors.green;
    } else {
      background = Colors.red;
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade100,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.calendar_today,
                      size: 18,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Profit/Loss",
                    style: TextStyles.body,
                  ),
                  Spacer(),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<FilterByDate>(
                      style: TextStyles.subtitleSm.withColor(Colors.black),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey.withOpacity(0)),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      icon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          )),
                      value: FilterByDate.allTime,
                      items: [
                        DropdownMenuItem(
                            value: FilterByDate.allTime,
                            child: Text(
                              "All",
                              style: TextStyles.subtitleSm,
                            )),
                        DropdownMenuItem(
                            value: FilterByDate.today, child: Text("Today")),
                        DropdownMenuItem(
                            value: FilterByDate.week, child: Text("This Week"))
                      ],
                      onChanged: (filter) async {
                        if (filter == FilterByDate.today ||
                            filter == FilterByDate.week) {
                          var totalExp = await InsightCommand()
                              .filterTotalExpenses(filter!);
                          var totalIn =
                              await InsightCommand().filterTotalIncome(filter);
                          setState(() {
                            widget.totalExpense = totalExp;
                            widget.totalIncome = totalIn;
                          });
                        } else {
                          setState(() {
                            widget.totalExpense =
                                widget.appModel.getTotalExpenses();
                            widget.totalIncome =
                                widget.appModel.getTotalIncome();
                          });
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colors.greenAccent.withOpacity(0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: background.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.white60,
                    width: 3,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: Text.rich(TextSpan(
                    text: currency,
                    style: TextStyles.moneyBody.withColor(background),
                    children: [
                      TextSpan(
                        text: gross,
                        style: TextStyles.subtitleSm.sizePlus.sizePlus
                            .withColor(background)
                            .boldest,
                      )
                    ])),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.arrow_drop_up,
                        color: Colors.green,
                        size: 36,
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Sales",
                          style: TextStyles.subtitleSm
                              .withColor(Colors.grey.shade600),
                        ),
                        Text.rich(TextSpan(
                            text: "+ $currency",
                            style: TextStyles.moneyBody,
                            children: [
                              TextSpan(
                                text: income,
                                style: TextStyles.subtitleSm.sizePlus,
                              )
                            ])),
                      ],
                    ),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.pink.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.pink,
                        size: 36,
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Expenses",
                          style: TextStyles.subtitleSm
                              .withColor(Colors.grey.shade600),
                        ),
                        Text.rich(TextSpan(
                            text: "- $currency",
                            style: TextStyles.moneyBody,
                            children: [
                              TextSpan(
                                text: expense,
                                style: TextStyles.subtitleSm.sizePlus,
                              )
                            ])),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ],
    );
  }
}
