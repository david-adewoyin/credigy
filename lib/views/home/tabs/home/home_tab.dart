import 'package:credigy/commands/insight_command.dart';
import 'package:credigy/services/app_service.dart';
import 'package:intl/intl.dart';
import 'package:credigy/components/custom_card_widget.dart';
import 'package:credigy/components/overview_widget.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/insights_tab.dart';
import 'package:credigy/views/home/tabs/home/add_sales_page.dart';
import 'package:credigy/views/home/tabs/home/transaction_page.dart';
import 'package:credigy/views/home/tabs/more/more_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    var bus = context.read<AppModel>().getBusinessUser();
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.maybeOf(context)!
              .push(MaterialPageRoute(builder: (context) {
            return const AddSalesTransaction();
          }));
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.redAccent.withOpacity(0.9)),
          child: const Icon(
            Icons.add,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Card(
              shape: const RoundedRectangleBorder(),
              elevation: 1,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 25, bottom: 20, left: 5, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dashboard",
                            style: TextStyles.subtitle
                                .withSize(28)
                                .medium
                                .withColor(Colors.black),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "${bus.businessName}",
                            style: TextStyles.subtitleSm.regular
                                .withColor(Colors.black)
                                .copyWith(letterSpacing: 1.5),
                          ),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const InsightWidget(),
            TransactionsSectionCard(),
            /* do not uncomment
               GeneralAccountsSectionCard(),
            OtherAccountsSectionCard(), */
            const MoreWidget(),
            const SizedBox(height: 20),
            BalanceSheetWidget(),
          ],
        ),
      ),
    );
  }
}

class BalanceSheetWidget extends StatelessWidget {
  BalanceSheetWidget({Key? key}) : super(key: key);
  Future<BalanceSheet>? future;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BalanceSheet>(
      future: future,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data!.totalInventory);
          print(snapshot.data!.cashAccount);
          print(snapshot.data!.bankAccount);
        }
        return Container();
      }),
    );
  }
}

class TransactionsSectionCard extends StatelessWidget {
  TransactionsSectionCard({
    Key? key,
  }) : super(key: key);
  final String _currency =
      NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

  List<Widget> buildTransactions(List<TransactionModel> transactions) {
    List<Widget> transWids = [];
    for (var t in transactions) {
      late Color c;
      late Color d;
      late Color e;
      switch (t.transactionType) {
        case TransactionModelType.sale:
          c = Colors.green.withOpacity(0.08);
          d = Colors.green.withOpacity(0.2);
          e = Colors.green;
          break;
        case TransactionModelType.expense:
          c = Colors.red.withOpacity(0.09);

          d = Colors.red.withOpacity(0.1);
          e = Colors.red;
          break;

        default:
          c = Colors.purple.withOpacity(0.09);
          d = Colors.purple.withOpacity(0.2);
          e = Colors.purple;
      }
      Widget wid = Container(
        padding: const EdgeInsets.symmetric(vertical: 2),
        decoration: BoxDecoration(
          color: c,
          border: const Border(
            bottom: BorderSide(
              width: 3,
              color: Colors.white,
            ),
          ),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 15),
          title: Text(
            t.transactionName,
            style: TextStyles.subtitleSm,
          ),
          subtitle: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        t.account == PaymentMethod.cash
                            ? "Cash Account"
                            : "Bank Account",
                        style: TextStyles.body,
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Container(
                color: d,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text.rich(
                  TextSpan(
                    text: t.transactionType == TransactionModelType.sale
                        ? "+ "
                        : "- ",
                    style: TextStyles.moneyBody.boldest.withColor(e),
                    children: [
                      TextSpan(
                        text: _currency,
                        style: TextStyles.moneyBody.boldest.withColor(e),
                      ),
                      TextSpan(
                        text: t.transactionType == TransactionModelType.sale
                            ? "${t.amount}"
                            : "${t.amount}",
                        style: TextStyles.subtitle.boldest.withColor(e),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      transWids.add(wid);
    }
    return transWids;
  }

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();

    List<TransactionModel> transactions = appModel.recentTransactions(3);
    print(transactions.length);

    if (transactions.isEmpty) {
      return Container();
    }

    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomCardWidget(heading: "Recent transactions"),
            ...buildTransactions(transactions),
            const SizedBox(height: 10),
            Container(
                padding: const EdgeInsets.only(left: 0),
                child: TextButton(
                    style: TextButton.styleFrom(primary: Colors.pink),
                    onPressed: () {
                      Navigator.maybeOf(context)!
                          .push(MaterialPageRoute(builder: (context) {
                        return const TransactionsPage();
                      }));
                    },
                    child: Text(
                      "View all transactions",
                      style: TextStyles.body,
                    ))),
          ],
        ),
      ),
    );
  }
}

/* class GeneralAccountsSectionCard extends StatelessWidget {
  const GeneralAccountsSectionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: const RoundedRectangleBorder(),
      child: Column(
        children: [
          const CustomCardWidget(heading: "Account overview"),
          const OverViewWidget(),
          const OverViewWidget(),
          const OverViewWidget(),
        ],
      ),
    );
  }
}
 */