import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/app_bar_with_back.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

// every wishlist fetch => cache list in shared pref
// in details => method to check if book in cached list (icon with color) or not (icon with black) BY [BOOK ID]!!
// IF clicked => add to wishlist => remove from wishlist

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoadingState) {
          showLoadingDialog(context);
        } else if (state is HomeSuccessState) {
          pop(context);
          showMyDialog(context, state.message ?? '', type: DialogType.success);
        } else if (state is HomeErrorState) {
          pop(context);
          showMyDialog(context, 'Something went wrong');
        }
      },
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Scaffold(
          appBar: AppBarWithBack(
            action: IconButton(
              onPressed: () {
                if (cubit.isWishlist(product.id ?? 0)) {
                  cubit.removeFromWishlist(productId: product.id ?? 0);
                } else {
                  cubit.addToWishlist(productId: product.id ?? 0);
                }
              },
              icon: SvgPicture.asset(
                AppImages.bookmarkSvg,
                colorFilter: ColorFilter.mode(
                  cubit.isWishlist(product.id ?? 0)
                      ? AppColors.primaryColor
                      : AppColors.darkColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          body: detailsBody(),
          bottomNavigationBar: bottomActions(),
        );
      },
    );
  }

  SafeArea bottomActions() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$${product.priceAfterDiscount}',
              style: TextStyles.styleSize24,
            ),
            Gap(40),
            Expanded(
              child: MainButton(
                bgColor: AppColors.darkColor,
                label: 'Add to cart',
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding detailsBody() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: product.id ?? '',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.image ?? '',
                    width: 200,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(AppImages.welcome, width: 180);
                    },
                  ),
                ),
              ),
              Gap(30),
              Text(product.name ?? '', style: TextStyles.styleSize30),
              Gap(10),
              Text(
                product.category ?? '',
                style: TextStyles.styleSize16.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              Gap(16),

              Text(
                product.description ?? '',
                textAlign: TextAlign.justify,
                style: TextStyles.styleSize14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
