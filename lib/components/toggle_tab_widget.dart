import 'package:credigy/styles.dart';
import 'package:flutter/material.dart';

//text //pressed

class ToggleTabWidget extends StatefulWidget {
  final List<ToggleTabButton> buttons;

  ToggleTabWidget({Key? key, required this.buttons}) : super(key: key);

  @override
  _ToggleTabWidgetState createState() => _ToggleTabWidgetState();
}

class _ToggleTabWidgetState extends State<ToggleTabWidget> {
  final activeNotifier = ValueNotifier<int>(0);
  late List<Widget> children;
  @override
  void dispose() {
    activeNotifier.dispose();
    super.dispose();
  }

  @override
  void initState() {
    children = buidButton(widget.buttons);
    super.initState();
  }

  List<Widget> buidButton(List<ToggleTabButton> buttons) {
    List<Widget> btnWidgets = [];
    buttons
        .asMap()
        .map(
          (index, btn) => MapEntry(
            index,
            btnWidgets.add(
              Flexible(
                child: _ToggleTabButton(
                    button: btn, activeNotifier: activeNotifier, index: index),
              ),
            ),
          ),
        )
        .values;

    print(btnWidgets.length);
    return btnWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Color(0xFF707070),
            width: 0.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class _ToggleTabButton extends StatefulWidget {
  final ToggleTabButton button;
  final ValueNotifier<int> activeNotifier;
  final int index;
  _ToggleTabButton(
      {required this.button,
      required this.activeNotifier,
      required this.index});

  @override
  _ToggleTabButtonState createState() => _ToggleTabButtonState();
}

class _ToggleTabButtonState extends State<_ToggleTabButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // splashColor: Colors.blue,
      onTap: () {
        if (widget.activeNotifier.value == widget.index) {
          return;
        }
        setState(() {
          widget.activeNotifier.value = widget.index;
          widget.button.onPressed();
        });
      },
      child: ValueListenableBuilder<int>(
        valueListenable: widget.activeNotifier,
        child: Text(widget.button.text),
        builder: (context, value, _) {
          return Container(
            width: double.infinity,
            alignment:
                widget.index == 0 ? Alignment.centerLeft : Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: widget.activeNotifier.value == widget.index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: widget.activeNotifier.value == widget.index
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: 0.3,
              ),
            ),
            child: Text(widget.button.text,
                textAlign: TextAlign.center,
                style: TextStyles.bodySm.withSize(13).copyWith(
                      color: widget.activeNotifier.value == widget.index
                          ? Colors.white
                          : Color(0xFF707070),
                    )),
          );
        },
      ),
    );
  }
}

class ToggleTabButton {
  final String text;
  final Function() onPressed;
  ToggleTabButton({
    required this.text,
    required this.onPressed,
  });
}
