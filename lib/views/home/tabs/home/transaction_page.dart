import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    List<TransactionModel> transactions = appModel.allTransactions();
    List<Widget> buildTransactionItems(List<TransactionModel> transactions) {
      List<Widget> transWids = [];
      for (var t in transactions) {
        var wid = TransactionItemWidget(
          transaction: t,
        );
        transWids.add(wid);
      }
      return transWids;
    }

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        shadowColor: Colors.white10,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: GestureDetector(
          onTap: () {
            Navigator.maybeOf(context)!.pop();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: Text(
          "Transactions",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 20),
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: buildTransactionItems(transactions),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionItemWidget extends StatelessWidget {
  final TransactionModel transaction;
  TransactionItemWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  late final Color c;
  late final Color d;
  late Color e;

  fincColor() {
    switch (transaction.transactionType) {
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
  }

  @override
  Widget build(BuildContext context) {
    final _currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;
    var _format = DateFormat.MMMEd();
    fincColor();
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color.fromRGBO(224, 224, 224, 1)))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
              contentPadding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 8, right: 15),
              title: Text(
                transaction.transactionName,
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
                            transaction.account == PaymentMethod.cash
                                ? "Cash Account"
                                : "Bank Account",
                            style: TextStyles.body,
                          ),
                        ],
                      ),
                      Text(
                        _format.format(transaction.dateTime),
                        style: TextStyles.body,
                      )
                    ],
                  ),
                  const Spacer(),
                  Container(
                    color: d,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Text.rich(
                      TextSpan(
                        text: transaction.transactionType ==
                                TransactionModelType.sale
                            ? "+ "
                            : "- ",
                        style: TextStyles.moneyBody.boldest.withColor(e),
                        children: [
                          TextSpan(
                            text: _currency,
                            style: TextStyles.moneyBody.boldest.withColor(e),
                          ),
                          TextSpan(
                            text: transaction.transactionType ==
                                    TransactionModelType.sale
                                ? "${transaction.amount}"
                                : "${transaction.amount}",
                            style: TextStyles.subtitle.boldest.withColor(e),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
