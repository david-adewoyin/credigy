import 'package:credigy/components/custom_card_widget.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class OtherAccountsSectionCard extends StatelessWidget {
  OtherAccountsSectionCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(),
      child: Column(
        children: [
          CustomCardWidget(heading: "As of today"),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20),
              title: Row(children: [
                Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      size: 16,
                      color: Colors.pink,
                    )),
                SizedBox(width: 14),
                Text(
                  "Receivable",
                  style: TextStyles.subtitleSm,
                ),
                Spacer(),
                Text(
                  "  \$ 5000.00",
                  style: TextStyles.subtitle,
                ),
              ]),
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
              contentPadding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 20),
              title: Row(children: [
                Container(
                    padding: EdgeInsets.all(7),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      Icons.arrow_upward_rounded,
                      size: 16,
                      color: Colors.deepPurple,
                    )),
                SizedBox(width: 14),
                Text(
                  "Payables",
                  style: TextStyles.subtitleSm,
                ),
                Spacer(),
                Text(
                  "  \$ 5000.00",
                  style: TextStyles.subtitle,
                ),
              ]),
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
              contentPadding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 20),
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
                  "Cash & Bank Balance",
                  style: TextStyles.subtitleSm,
                ),
                Spacer(),
                Text(
                  "  \$ 5000.00",
                  style: TextStyles.subtitle,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
