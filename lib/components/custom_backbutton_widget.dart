import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  /// Creates an [IconButton] with the appropriate "back" icon for the current
  /// target platform.
  const CustomBackButton({Key? key, this.color, this.onPressed})
      : super(key: key);

  /// The color to use for the icon.
  ///
  /// Defaults to the [IconThemeData.color] specified in the ambient [IconTheme],
  /// which usually matches the ambient [Theme]'s [ThemeData.iconTheme].
  final Color? color;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SystemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///
  /// Defaults to null.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterialLocalizations(context));
    return GestureDetector(
      // padding: EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: const BackButtonIcon()),
      // icon: const BackButtonIcon(),
      // color: color,
      // tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}
