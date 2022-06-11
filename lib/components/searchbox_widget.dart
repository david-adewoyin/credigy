import 'package:credigy/components/textfield.dart';
import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class SearchBoxWidget extends StatelessWidget {
  final String hintText;
  final dynamic Function(String?)? onSubmit;
  final TextEditingController controller = TextEditingController();
  final bool readOnly;
  final Function()? onTap;
  SearchBoxWidget({
    Key? key,
    required this.hintText,
    this.onTap,
    this.readOnly = false,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 320,
          child: UiTextField(
            readOnly: readOnly,
            onTap: onTap,
            onSubmit: onSubmit,
            hintText: hintText,
            controller: controller,
            textInputAction: TextInputAction.search,
            borderColor: Color(0xFFAEAEAE),
            hintStyle: TextStyles.bodySm.copyWith(
              color: Color(0xFFAEAEAE),
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF1594E8),
            borderRadius: BorderRadius.circular(4),
          ),
          child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (onSubmit != null) {
                  if (controller.text.isNotEmpty) onSubmit!(controller.text);
                }
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ),
      ],
    );
  }
}
