import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.bgColor = AppColors.primaryColor,
    this.textColor = AppColors.whiteColor,
    this.borderColor,
    this.height = 55,
    this.width = double.infinity,
  });

  final String text;
  final Function() onPressed;
  final Color bgColor;
  final Color textColor;
  final Color? borderColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          side: borderColor != null
              ? BorderSide(color: borderColor ?? Colors.transparent)
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyles.body.copyWith(color: textColor)),
      ),
    );
  }
}
