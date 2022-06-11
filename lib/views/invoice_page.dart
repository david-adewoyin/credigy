import 'package:credigy/commands/insight_command.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/home/add_sales_page.dart';
import 'package:credigy/views/home/tabs/home/invoice_details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoicePage extends StatelessWidget {
  InvoicePage({Key? key}) : super(key: key);
  Future<List<InvoiceModel>> future = InsightCommand().getInvoices();
  var _format = DateFormat.MMMMEEEEd();

  Widget buildInvoice(InvoiceModel inv, BuildContext context) {
    int id = inv.id!;

    var date = _format.format(inv.date);
    return ListTile(
      onTap: () {
        Navigator.maybeOf(context)!.push(MaterialPageRoute(builder: (context) {
          return InvoiceDetails(
            invoice: inv,
          );
        }));
      },
      leading: Container(padding: EdgeInsets.all(8), child: Icon(Icons.star)),
      title: Text("Inv #$id", style: TextStyles.subtitleSm),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inv.status.displayName(),
            style: TextStyles.subtitleSm.withColor(Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            date,
            style: TextStyles.body,
          )
        ],
      ),
      trailing: const Icon(Icons.chevron_right_rounded),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Invoices List",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      body: FutureBuilder<List<InvoiceModel>>(
        future: future,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!;
            if (data.isEmpty) {
              return Container(
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/store.png",
                        width: 100,
                      ),
                      SizedBox(height: 20),
                      Text(
                        "You haven't created an invoice",
                        style: TextStyles.subtitle,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                for (var inv in data) ...[
                  buildInvoice(inv, context),
                ],
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
