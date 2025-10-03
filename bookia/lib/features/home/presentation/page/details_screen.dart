import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/app_bar_with_back.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithBack(
        action: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppImages.bookmarkSvg),
        ),
      ),
      body: Padding(
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
      ),
      bottomNavigationBar: SafeArea(
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
      ),
    );
  }
}
