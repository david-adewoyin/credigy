import 'package:credigy/commands/insight_command.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/models/transaction_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceDetails extends StatelessWidget {
  final InvoiceModel invoice;
  final _currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

  InvoiceDetails({Key? key, required this.invoice}) : super(key: key);

  buildRow(ProductTransactionModel product) {
    var amt = product.sellingPrice;
    if (product.quantity != null) {
      amt = product.quantity! * product.sellingPrice;
    }
    return TableRow(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(product.name),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text.rich(
            TextSpan(
              text: _currency,
              style: TextStyles.moneyBody,
              children: [
                TextSpan(
                  text: "${amt}",
                  style: TextStyles.body,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    String _currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;
    var format = DateFormat.yMMMEd();

    var buss = appModel.getBusinessUser();
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 50),
        child: ListView(
          children: [
            SafeArea(
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Invoice",
                      style: TextStyles.h5.boldest,
                    ),
                    Text(format.format(DateTime.now())),
                    if (invoice.status == InvoiceStatus.unpaid)
                      TextButton(
                        onPressed: () async {
                          try {
                            await InsightCommand()
                                .markInvoiceHasPaid(invoice.id!);
                            ScaffoldMessenger.maybeOf(context)!.showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                        "Invoice has been marked as paid")));
                            Navigator.pushNamedAndRemoveUntil(context,
                                LandingPage.routeName, (route) => false);
                          } catch (e) {
                            ScaffoldMessenger.maybeOf(context)!
                                .showSnackBar(SnackBar(
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Unable to perform action",
                                      style: TextStyles.body
                                          .withColor(Colors.white),
                                    )));
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mark as paid",
                              style: TextStyles.subtitleSm,
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(buss.businessName, style: TextStyles.body.bold),
                  SizedBox(height: 5),
                  Text(buss.businessAddress, style: TextStyles.body),
                  SizedBox(height: 5),
                  Text(buss.email, style: TextStyles.body),
                  SizedBox(height: 5),
                  Text(buss.phone, style: TextStyles.body),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Bill To",
              style: TextStyles.subtitle,
            ),
            SizedBox(height: 10),
            Text(invoice.customer.name, style: TextStyles.body),
            if (invoice.customer.address != null)
              Text("${invoice.customer.address}", style: TextStyles.body),
            if (invoice.customer.email != null)
              Text("${invoice.customer.email}", style: TextStyles.body),
            if (invoice.customer.phone != null)
              Text("${invoice.customer.phone}", style: TextStyles.body),
            SizedBox(height: 30),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                  right: BorderSide(color: Colors.pink),
                  left: BorderSide(color: Colors.pink),
                  verticalInside: BorderSide(color: Colors.blue),
                  top: BorderSide(color: Colors.pink),
                  horizontalInside:
                      BorderSide(color: Colors.pink.withOpacity(0.2)),
                  bottom: BorderSide(color: Colors.pink)),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Description"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: EdgeInsets.all(8.0),
                      child: Text("Amount"),
                    ),
                  ],
                ),
                for (var p in invoice.sale.products) ...[
                  buildRow(p),
                ],
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "Total: ",
                  style: TextStyles.subtitleSm,
                ),
                SizedBox(width: 15),
                Text.rich(
                  TextSpan(
                    text: _currency,
                    style: TextStyles.moneyBody,
                    children: [
                      TextSpan(
                        text: "${invoice.sale.totalAmount}",
                        style: TextStyles.subtitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
                child: Text("Thank you for your business",
                    style: TextStyles.subtitle))
          ],
        ),
      ),
    );
  }
}
