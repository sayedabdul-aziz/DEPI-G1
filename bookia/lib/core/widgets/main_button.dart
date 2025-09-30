import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.bgColor = AppColors.primaryColor,
    this.textColor = AppColors.backgroundColor,
    this.borderColor,
    this.height = 55,
    this.width = double.infinity,
  });

  final String label;
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyles.styleSize15.copyWith(color: textColor),
        ),
      ),
    );
  }
}
