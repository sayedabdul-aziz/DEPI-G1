import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/constants/app_strings.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Divider()),
            const Gap(10),
            Text(AppStrings.or, style: TextStyles.styleSize15),
            const Gap(10),
            Expanded(child: Divider()),
          ],
        ),
        Gap(20),
        SocialButton(
          image: AppImages.googleSvg,
          label: AppStrings.loginWithGoogle,
          onPressed: () {},
        ),
        Gap(15),
        SocialButton(
          image: AppImages.appleSvg,
          label: AppStrings.loginWithApple,
          onPressed: () {},
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.image,
    required this.label,
    required this.onPressed,
  });

  final String image;
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            const Gap(10),
            Text(label, style: TextStyles.styleSize15),
          ],
        ),
      ),
    );
  }
}
