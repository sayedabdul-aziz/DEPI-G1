import 'package:flutter/material.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';

showAlertDialog(
  BuildContext context, {
  required String actionText,
  required String title,
  void Function()? onTap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.accentColor,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Icon(Icons.check, size: 50, color: AppColors.darkColor),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyles.title.copyWith(color: AppColors.darkColor),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.secondaryColor,
                    ),
                    child: Text(actionText, style: TextStyles.body),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
