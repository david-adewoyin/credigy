import 'package:credigy/commands/app_command.dart';
import 'package:credigy/commands/insight_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/insight_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/services/app_service.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/add_inventory_page.dart';
import 'package:credigy/views/home/tabs/inventory/modify_inventory_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class IncomeStatementPage extends StatelessWidget {
  static const routeName = "/inventory";
  IncomeStatementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "View Income Statement",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      body: IncomeContainer(),
    );
  }
}

class IncomeContainer extends StatefulWidget {
  const IncomeContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<IncomeContainer> createState() => _IncomeContainerState();
}

class _IncomeContainerState extends State<IncomeContainer> {
  DateTime? selectedDate;
  Future<IncomeStatement>? future;
  DateTime businessStartDate = AppCommand().getBusinessStartDate();
  late final ScreenshotController _screenshotController =
      ScreenshotController();
  @override
  Widget build(BuildContext context) {
    var appModel = context.read<AppModel>();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(),
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      "Select Month",
                      style: TextStyles.body,
                    ),
                  ),
                  SizedBox(height: 20),
                  DateTimeFormField(
                    mode: DateTimeFieldPickerMode.date,
                    firstDate: businessStartDate,
                    lastDate: DateTime.now(),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: "Select Month to fetch Income Statement",
                      label: Text("Month", style: TextStyles.body),
                      prefixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                    ),
                    onDateSelected: (value) {
                      setState(() {
                        selectedDate = value;
                        future = InsightCommand().getIncomeStatement(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<IncomeStatement>(
              future: future,
              builder: (context, snapshot) {
                print(snapshot.connectionState.toString());
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(flex: 1),
                        Icon(
                          Icons.dataset_rounded,
                          size: 42,
                          color: Colors.pink,
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Income Statement for ${selectedDate!.month}/${selectedDate!.year}",
                          style: TextStyles.subtitle,
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                var c = await _screenshotController
                                    .captureFromWidget(
                                  IncomeWid(
                                    appModel: appModel,
                                    income: snapshot.data!,
                                    date: selectedDate!,
                                  ),
                                  context: context,
                                );
                                await ImageGallerySaver.saveImage(c);
                                ScaffoldMessenger.maybeOf(context)!
                                    .showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        "Income Statement successfully saved to gallery"),
                                  ),
                                );
                                return;
                              } catch (e) {
                                print(e);
                                ScaffoldMessenger.maybeOf(context)!
                                    .showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "unable to save into gallery",
                                      style: TextStyles.body
                                          .withColor(Colors.white),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text("Save into gallery")),
                        Spacer(
                          flex: 3,
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 1),
                      Icon(
                        Icons.dataset_rounded,
                        size: 42,
                        color: Colors.pink,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Income Statment",
                        style: TextStyles.subtitle,
                      ),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class IncomeWid extends StatelessWidget {
  final DateTime date;
  final IncomeStatement income;
  final AppModel appModel;
  final format = DateFormat.yMEd();
  IncomeWid(
      {Key? key,
      required this.appModel,
      required this.date,
      required this.income})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = appModel.getBusinessUser();
    var _date = format.format(date);
    var totalExp = 0.0;
    for (var i in income.expenseStatement.items) {
      totalExp = totalExp + i.amount;
    }
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    user.businessName,
                    style: TextStyles.body.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text("Income Statement for $_date",
                    style: TextStyles.body.bold),
              ],
            ),
            SizedBox(height: 20),
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: IntrinsicColumnWidth(),
                2: FlexColumnWidth(1),
              },
              border: TableBorder(
                top: BorderSide(color: Colors.grey.shade800),
                bottom: BorderSide(color: Colors.grey.shade800),
                left: BorderSide(color: Colors.grey.shade800),
                right: BorderSide(color: Colors.grey.shade800),
                horizontalInside: BorderSide(color: Colors.grey.shade800),
                verticalInside: BorderSide(color: Colors.grey.shade800),
              ),
              children: [
                TableRow(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Text("Revenue", style: TextStyles.body)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text("Merchandise And Services",
                          style: TextStyles.body),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text("${income.saleAndService}",
                          style: TextStyles.body),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Text("Expenses", style: TextStyles.body),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var exp in income.expenseStatement.items) ...[
                            Text(exp.expenseDescription,
                                style: TextStyles.body),
                          ],
                          Text("Total Expenses", style: TextStyles.body),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var exp in income.expenseStatement.items) ...[
                            Text("${exp.amount}", style: TextStyles.body),
                          ],
                          Text("$totalExp", style: TextStyles.body),
                        ],
                      ),
                    ),
                  ],
                ),
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text("Net Income", style: TextStyles.body),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text(
                      "Revenue - Expenses",
                      style: TextStyles.body,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Text("${income.saleAndService - totalExp}",
                        style: TextStyles.body),
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
