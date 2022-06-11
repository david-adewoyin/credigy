// ignore_for_file: prefer_const_constructors

import 'package:credigy/commands/app_command.dart';
import 'package:credigy/commands/insight_command.dart';
import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/services/app_service.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/add_inventory_page.dart';
import 'package:credigy/views/home/tabs/inventory/modify_inventory_page.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class BalanceSheetPage extends StatelessWidget {
  static const routeName = "/inventory";
  BalanceSheetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "View BalanceSheet",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      body: BalanceContainer(),
    );
  }
}

class BalanceContainer extends StatefulWidget {
  const BalanceContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<BalanceContainer> createState() => _BalanceContainerState();
}

class _BalanceContainerState extends State<BalanceContainer> {
  DateTime? selectedDate;
  Future<BalanceSheet>? future;
  DateTime businessStartDate = AppCommand().getBusinessStartDate();

  late final ScreenshotController _screenshotController =
      ScreenshotController();

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();

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
                      hintText: "Select Month to fetch BalanceSheet",
                      label: Text("Month", style: TextStyles.body),
                      prefixIcon: Icon(Icons.calendar_month),
                      border: OutlineInputBorder(),
                    ),
                    onDateSelected: (value) {
                      setState(() {
                        selectedDate = value;
                        future = InsightCommand().getBalanceSheet(value);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<BalanceSheet>(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var data = snapshot.data;
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
                          "Balance Sheet for ${selectedDate!.month}/${selectedDate!.year}",
                          style: TextStyles.subtitle,
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {
                              try {
                                var c = await _screenshotController
                                    .captureFromWidget(
                                  BalanceWid(
                                    date: selectedDate!,
                                    balanceSheet: data!,
                                    appModel: appModel,
                                  ),
                                  context: context,
                                );
                                await ImageGallerySaver.saveImage(c);
                                ScaffoldMessenger.maybeOf(context)!
                                    .showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        "BalanceSheet successfully saved to gallery"),
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
                        "Balance Sheet",
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

class BalanceWid extends StatelessWidget {
  final DateTime date;
  final BalanceSheet balanceSheet;
  final AppModel appModel;
  final format = DateFormat.yMEd();
  BalanceWid(
      {Key? key,
      required this.date,
      required this.balanceSheet,
      required this.appModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = appModel.getBusinessUser();
    var name = user.businessName;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      name,
                      style: TextStyles.body.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Condensed Balance Sheet", style: TextStyles.body.bold),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  format.format(
                    date,
                  ),
                  style: TextStyles.body.bold
                      .copyWith(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Assets",
                style: TextStyles.body,
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 15),
                  Text("Current assets", style: TextStyles.body)
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text("Cash Account", style: TextStyles.body),
                  Spacer(),
                  Text("${balanceSheet.cashAccount}", style: TextStyles.body)
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text("Bank Account", style: TextStyles.body),
                  Spacer(),
                  Text("${balanceSheet.bankAccount}", style: TextStyles.body),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text("Inventories", style: TextStyles.body),
                  Spacer(),
                  Text("${balanceSheet.totalInventory}",
                      style: TextStyles.body),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 30),
                  Text("Total Assets",
                      style: TextStyles.body.withColor(Colors.blue).bold),
                  Spacer(),
                  Column(
                    children: [
                      Divider(),
                      Text(
                          "${balanceSheet.bankAccount + balanceSheet.cashAccount + balanceSheet.totalInventory}",
                          style: TextStyles.body.withColor(Colors.blue)),
                      Divider(),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
