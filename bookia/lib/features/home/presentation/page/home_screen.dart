import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller_builder.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

// Person p = Person()..name = "ahmed"

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..fetchHomeData(),
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(AppImages.logoSvg, height: 30),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImages.searchSvg),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: SingleChildScrollView(
                child: Skeletonizer(
                  enabled: state is! HomeSuccessState,
                  effect: ShimmerEffect(
                    baseColor: AppColors.accentColor,
                    highlightColor: AppColors.accentColor.withValues(alpha: .6),
                    duration: Duration(seconds: 1),
                  ),
                  child: Column(
                    children: [
                      HomeSlider(sliders: cubit.sliders),
                      Gap(20),
                      BestSellerBuilder(products: cubit.products),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
