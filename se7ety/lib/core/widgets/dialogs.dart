import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/utils/app_colors.dart';

enum DialogType { error, success }

showMyDialog(
  BuildContext context,
  String message, {
  DialogType type = DialogType.error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type == DialogType.error
          ? Colors.red
          : AppColors.primaryColor,
    ),
  );
}

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: AppColors.darkColor.withValues(alpha: .7),
    builder: (context) => Center(child: Lottie.asset(AppImages.loadingJson)),
  );
}
