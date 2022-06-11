import 'package:credigy/models/app_model.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class HomeTabPage extends StatelessWidget {
  const HomeTabPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    var user = appModel.user;
    if (user == null) {
      return Container();
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(right: 100),
            child: Text(
              "Hi, ${user.lastname}. Get help and explore with us?",
              style: TextStyles.h4.bold,
              maxLines: 4,
            ),
          ),

          SizedBox(height: 80),
          Text(
            "My location",
            style: TextStyles.body.sizePlus.sizePlus,
          ),
          SizedBox(height: 20),
          Container(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            height: 130,
            width: double.infinity,
            child: Stack(
              children: [
                SizedBox(
                  height: 130,
                  child: Image.asset("assets/images/location_background.png"),
                ),
                Align(
                    alignment: Alignment(0.8, 0),
                    child: Text(
                        "${user.currentCity}, ${user.currentCountry ?? 'location not set'}")),
              ],
            ),
          ),
          //   ],
          SizedBox(height: 30),
          Text(
            "Search for",
            style: TextStyles.bodySm.sizePlus,
          ),
          SizedBox(height: 20),
       
        ],
      ),
    );
  }
}