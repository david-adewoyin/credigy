import 'package:credigy/styles.dart';
import 'package:credigy/views/home/bottomsheets/add_cash_bottomsheet.dart';
import 'package:credigy/views/home/bottomsheets/add_customer_bottomsheet.dart';
import 'package:credigy/views/home/bottomsheets/add_expense_bottomsheet.dart';
import 'package:credigy/views/home/bottomsheets/add_purchase_bottomsheet.dart';
import 'package:credigy/views/home/bottomsheets/withraw_cash_bottomsheet.dart';
import 'package:credigy/views/home/tabs/inventory/add_inventory_page.dart';
import 'package:credigy/views/home/tabs/home/home_tab.dart';
import 'package:credigy/views/home/tabs/inventory/inventory_tab.dart';
import 'package:credigy/views/home/tabs/insights_tab.dart';
import 'package:credigy/views/home/tabs/more/more_tab.dart';
import 'package:credigy/views/home/tabs/home/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bottomsheets/add_supplier_bottomsheet.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = "/landing_page";

  const LandingPage({Key? key}) : super(key: key);
  @override
  _LandingHomePage createState() => _LandingHomePage();
}

class _LandingHomePage extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  bool showAppBar = true;
  late TabController _controller;
  var _currentIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    _controller.animateTo(_currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _controller,
          children: [
            HomeTab(),
            /*   InsightTab(), */
            InventoryTab(),
          ],
        ),
        floatingActionButton: Container(
            padding: const EdgeInsets.only(top: 20),
            child: const Icon(
              Icons.horizontal_rule_rounded,
              color: const Color(0x66000000),
              size: 38,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Card(
          child: DraggableScrollableSheet(
            initialChildSize: 0.07,
            maxChildSize: 0.3,
            expand: false,
            snap: true,
            minChildSize: 0.07,
            builder: ((context, scrollController) {
              return Container(
                color: Colors.white,
                child: ListView(controller: scrollController, children: [
                  Container(
                    child: BottomNavigationBar(
                      selectedItemColor: Colors.black,
                      unselectedItemColor: const Color(0x66000000),
                      selectedLabelStyle:
                          TextStyles.bodySm.sizeMinus.withSize(11).bold,
                      unselectedLabelStyle:
                          TextStyles.bodySm.sizeMinus.withSize(11).bold,
                      currentIndex: _currentIndex,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      showUnselectedLabels: true,
                      elevation: 0,
                      onTap: (value) {
                        if (value == 3) {
                          setState(() {
                            showAppBar = false;
                          });
                        } else {
                          setState(() {
                            showAppBar = true;
                          });
                        }
                        setState(() {
                          _currentIndex = value;
                          _controller.animateTo(
                            value,
                            duration: const Duration(milliseconds: 10),
                          );
                        });
                      },
                      items: [
                        BottomNavigationBarItem(
                            activeIcon: Icon(Icons.home),
                            icon: Icon(Icons.home_rounded),
                            label: "Home"),
                        /*    const BottomNavigationBarItem(
                            icon: const Icon(Icons.insert_chart_rounded),
                            label: "Insights"), */
                        BottomNavigationBarItem(
                            icon: Icon(Icons.inventory), label: "Inventory"),
                        /*     const BottomNavigationBarItem(
                            icon: Icon(Icons.menu_rounded), label: "More"), */
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const AddExpenseBottomSheet();
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.white,
                                onPrimary: Colors.orange,
                                side: BorderSide(
                                    color: Colors.orange.withOpacity(0.7))),
                            child: const Text("Add Expenses")),
                      ),
                      const SizedBox(width: 10),
                      /*  Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const AddPurchaseBottomSheet();
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.white,
                                onPrimary: Color.fromARGB(255, 0, 171, 20),
                                side: BorderSide(
                                    color: const Color.fromARGB(255, 0, 171, 20)
                                        .withOpacity(0.7))),
                            child: const Text("Add Purchases")),
                      ), */
                    ],
                  ),
                  Row(
                    children: [
                  /*     Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const AddCashBottomSheet();
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.white,
                                onPrimary: Colors.pink,
                                side: BorderSide(
                                    color: Colors.pink.withOpacity(0.7))),
                            child: const Text("Add Money")),
                      ), */
                      /*   const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const WithdrawCashBottomSheet();
                                  });
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.white,
                                onPrimary:
                                    const Color.fromARGB(255, 20, 0, 171),
                                side: BorderSide(
                                    color: const Color.fromARGB(255, 20, 0, 171)
                                        .withOpacity(0.7))),
                            child: const Text("Withdraw Money")),
                      ),
                    */
                    ],
                  ),
                  /*      Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.white,
                                onPrimary:
                                    const Color.fromARGB(255, 171, 0, 157),
                                side: BorderSide(
                                    color:
                                        const Color.fromARGB(255, 171, 0, 157)
                                            .withOpacity(0.7))),
                            child: const Text("Create Receipt")),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                primary: Colors.white,
                                onPrimary: Colors.deepOrange,
                                side: BorderSide(
                                    color: Colors.deepOrange.withOpacity(0.7))),
                            child: const Text("Create Invoice")),
                      ),
                    ],
                  ),
              */
                ]),
              );
            }),
          ),
        ),
      ),
    );
  }
}
