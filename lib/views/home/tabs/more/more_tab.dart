import 'package:credigy/components/custom_card_widget.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/home/invoice_details.dart';
import 'package:credigy/views/home/tabs/more/balancesheet_statement.dart';
import 'package:credigy/views/home/tabs/more/customers_page.dart';
import 'package:credigy/views/home/tabs/more/income_statement.dart';
import 'package:credigy/views/home/tabs/more/supplier_page.dart';
import 'package:credigy/views/invoice_page.dart';
import 'package:flutter/material.dart';

class MoreTab extends StatelessWidget {
  const MoreTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "More",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      body: MoreWidget(),
    );
  }
}

class MoreWidget extends StatelessWidget {
  const MoreWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: CustomCardWidget(
                heading: "More", icon: Icons.star_border_purple500_rounded),
          ),
          ListTile(
            leading: Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: Colors.orange.withOpacity(0.2)),
                child: Icon(Icons.star)),
            onTap: () {
              Navigator.maybeOf(context)!
                  .push(MaterialPageRoute(builder: (context) {
                return CustomersPage();
              }));
            },
            title: Text("Customers", style: TextStyles.subtitleSm),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          Divider(
            color: Colors.grey.shade500,
          ),
          ListTile(
            onTap: () {
              Navigator.maybeOf(context)!
                  .push(MaterialPageRoute(builder: (context) {
                return SuppliersPage();
              }));
            },
            leading: Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(color: Colors.purple.withOpacity(0.2)),
                child: Icon(Icons.star)),
            title: Text("Suppliers", style: TextStyles.subtitleSm),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          Divider(
            color: Colors.grey.shade500,
          ),
          ListTile(
            onTap: () {
              Navigator.maybeOf(context)!
                  .push(MaterialPageRoute(builder: (context) {
                return InvoicePage();
              }));
            },
            leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.2)),
                child: Icon(Icons.star)),
            title: Text("Invoices", style: TextStyles.subtitleSm),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          Divider(
            color: Colors.grey.shade500,
          ),
          ListTile(
            onTap: () {
              Navigator.maybeOf(context)!
                  .push(MaterialPageRoute(builder: (context) {
                return BalanceSheetPage();
              }));
            },
            leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.2)),
                child: Icon(Icons.star)),
            title: Text("View BalanceSheet Statement",
                style: TextStyles.subtitleSm),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          Divider(
            color: Colors.grey.shade500,
          ),
          ListTile(
            onTap: () {
              Navigator.maybeOf(context)!
                  .push(MaterialPageRoute(builder: (context) {
                return IncomeStatementPage();
              }));
            },
            leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.2)),
                child: Icon(Icons.star)),
            title: Text("View Income Statement", style: TextStyles.subtitleSm),
            trailing: const Icon(Icons.chevron_right_rounded),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
