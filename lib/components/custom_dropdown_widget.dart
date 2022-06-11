import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

class CustomDropDownWidget<T> extends StatelessWidget {
  final _accentColor = Color(0xFF1594E8);
  final Function(T value) onChanged;
  final T intialValue;
  final List<DropdownMenuItem<T>> items;

  CustomDropDownWidget({
    Key? key,
    required this.intialValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      //  value:  intialValue,
      icon: Icon(Icons.keyboard_arrow_down_rounded),
      onChanged: (value) {},
      decoration: InputDecoration(
        isDense: true,
        hintStyle: TextStyles.bodySm,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusColor: _accentColor,
        border: OutlineInputBorder(),
      ),
      items: items,
    );
  }
}
