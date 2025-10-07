import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/datum.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key, required this.book, required this.onRemove});

  final WishlistProduct book;
  final Function() onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onRemove();
      },
      background: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.redColor,
          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(Icons.delete, color: AppColors.backgroundColor),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () {
          pushTo(context, Routes.details, extra: book.mapToProduct());
        },
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  book.image ?? '',
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(AppImages.welcome, width: 180);
                  },
                ),
              ),
              Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.name ?? '', style: TextStyles.styleSize16),
                    Gap(5),
                    Text('\$${book.price}', style: TextStyles.styleSize16),
                    Gap(6),
                    Text(
                      book.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.styleSize14.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
