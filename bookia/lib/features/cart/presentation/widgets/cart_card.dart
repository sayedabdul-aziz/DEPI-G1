import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.book,
    required this.onRemove,
    required this.onUpdate,
    required this.onRefresh,
  });

  final CartItem book;
  final Function() onRemove;
  final Function(int) onUpdate;
  final Function() onRefresh;

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
          // pushTo(context, Routes.details, extra: book.mapToProduct()).then((v) {
          //   // when pop => refresh
          //   onRefresh();
          // });
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
                  book.itemProductImage ?? '',
                  width: 100,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.welcome,
                      width: 100,
                      height: 120,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.itemProductName ?? '',
                      style: TextStyles.styleSize16,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(5),
                    Text(
                      '\$${book.itemProductPriceAfterDiscount}',
                      style: TextStyles.styleSize16,
                    ),
                    Gap(20),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if ((book.itemQuantity ?? 1) > 1) {
                              int newQuantity = (book.itemQuantity ?? 1) - 1;
                              onUpdate(newQuantity);
                            } else {
                              showMyDialog(context, 'Minimum quantity is 1');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Gap(10),
                        Text(
                          book.itemQuantity.toString(),
                          style: TextStyles.styleSize16,
                        ),
                        Gap(10),
                        GestureDetector(
                          onTap: () {
                            if ((book.itemQuantity ?? 1) <
                                (book.itemProductStock ?? 1)) {
                              int newQuantity = (book.itemQuantity ?? 1) + 1;
                              onUpdate(newQuantity);
                            } else {
                              showMyDialog(context, 'Out of stock');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(Icons.add),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Total: \$${book.itemTotal?.toStringAsFixed(1)}',
                          style: TextStyles.styleSize16,
                        ),
                      ],
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
