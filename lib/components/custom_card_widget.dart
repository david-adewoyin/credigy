import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String heading;
  final IconData? icon;
  const CustomCardWidget({
    required this.heading,
    this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  icon ?? Icons.calendar_today,
                  size: 18,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                heading,
                style: TextStyles.body,
              ),
            ],
          )
        ],
      ),
    );
  }
}
