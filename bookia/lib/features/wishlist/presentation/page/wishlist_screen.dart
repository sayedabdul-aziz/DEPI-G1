import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:bookia/features/wishlist/presentation/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(title: Text('Wishlist')),
        body: BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            var cubit = context.read<WishlistCubit>();
            // state is success and my books is empty
            if (cubit.books.isEmpty) {
              return _emptyUI();
            } else {
              return Skeletonizer(
                enabled: state is! WishlistSuccessState,
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: cubit.books.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return WishlistCard(
                      book: cubit.books[index],
                      onRemove: () {
                        cubit.removeFromWishlist(
                          productId: cubit.books[index].id ?? 0,
                        );
                      },
                      onRefresh: () {
                        cubit.getWishlist();
                      },
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Center _emptyUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImages.bookmarkSvg,
            width: 100,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          Gap(20),
          Text('No books in wishlist', style: TextStyles.styleSize16),
        ],
      ),
    );
  }
}
