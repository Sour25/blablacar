import 'package:flutter/material.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/bla_icon_button.dart';

class RidePrefInput extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;

  final bool isPlaceHolder;

  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;

  const RidePrefInput({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed,
    this.isPlaceHolder = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isPlaceHolder
        ? BlaColors.textLight
        : BlaColors.textNormal;

    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(color: textColor),
      ),
      leading: Icon(leftIcon, size: 24, color: BlaColors.iconLight),
      trailing: rightIcon != null
          ? BlaIconButton(icon: rightIcon!, onPressed: onRightIconPressed)
          : null,
    );
  }
}
