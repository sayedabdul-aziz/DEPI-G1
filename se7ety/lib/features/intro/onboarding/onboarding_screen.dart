import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/core/helper/media_query.dart';
import 'package:se7ety/core/routes/navigations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/app_colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/core/widgets/main_button.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          if (currentIndex != onboardingList.length - 1)
            TextButton(
              onPressed: () {
                SharedPref.setIsOnBoardingShown(true);
                pushWithReplacement(context, Routes.welcome);
              },
              child: Text('تخطى', style: TextStyles.body),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: onboardingList.length,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Spacer(),
                      SvgPicture.asset(
                        onboardingList[index].imagePath,
                        width: context.width * .8,
                      ),
                      Spacer(),
                      Text(
                        onboardingList[index].title,
                        style: TextStyles.title.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Gap(20),
                      SizedBox(
                        width: context.width * .8,
                        child: Text(
                          onboardingList[index].description,
                          style: TextStyles.body,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(flex: 3),
                    ],
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardingList.length,
                    effect: const ExpandingDotsEffect(
                      dotWidth: 15,
                      dotHeight: 10,
                      expansionFactor: 2,
                      dotColor: AppColors.greyColor,
                      activeDotColor: AppColors.primaryColor,
                    ),
                  ),
                  if (currentIndex == onboardingList.length - 1)
                    MainButton(
                      width: 100,
                      height: 45,
                      text: 'هيا بنا',
                      onPressed: () {
                        SharedPref.setIsOnBoardingShown(true);
                        pushWithReplacement(context, Routes.welcome);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
