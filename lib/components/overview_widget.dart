/* import 'package:credigy/styles.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';

class OverViewWidget extends StatelessWidget {
  const OverViewWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2,bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 8, left: 5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sales",
                  style: TextStyles.subtitleSm.withSize(20),
                ),
                SizedBox(height: 8),
                Text(
                  "\$500,00",
                  style:
                      TextStyles.subtitle.withSize(24).withColor(Colors.black),
                ),
                SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.red.withOpacity(0.1),borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.arrow_drop_up, color: Colors.red.withOpacity(0.7)),
                    ),
                    SizedBox(width: 5,),
                    Text(
                      "19% vs Previous 7 days",
                      style: TextStyles.bodySm.medium.withColor(Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ],
            ),
Spacer(),
            LineGraph(
              features: [
                Feature(
                    data: [0.1, 0.2, 0.3, 0.4, 0.8], color: Colors.deepPurple),
              ],
              size: Size(150, 60),
              labelX: ['', '', '', '', ''],
              labelY: ['', '', '', '', ''],
              graphColor: Colors.transparent,
              graphOpacity: 0.3,
            ),
          ],
        ),
      ),
    );
  }
}
 */