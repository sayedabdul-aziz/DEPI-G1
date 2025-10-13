import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: BlocConsumer<CartCubit, CartState>(
          buildWhen: (previous, current) =>
              current is CartLoadingState ||
              current is CartSuccessState ||
              current is CartErrorState,
          listener: (context, state) {
            if (state is CheckoutSuccessState) {
              String total =
                  (context.read<CartCubit>().cartResponse?.data?.total) ?? '0';
              pop(context);
              pushTo(context, Routes.placeOrder, extra: total);
            } else if (state is CheckoutLoadingState) {
              showLoadingDialog(context);
            } else if (state is CheckoutErrorState) {
              pop(context);
              showMyDialog(context, 'something went wrong');
            } else if (state is CartErrorState) {
              showMyDialog(context, 'something went wrong');
            }
          },
          builder: (context, state) {
            var cubit = context.read<CartCubit>();
            var books = cubit.cartResponse?.data?.cartItems ?? [];

            if (books.isEmpty) {
              return _emptyUI();
            } else {
              return Skeletonizer(
                enabled: state is! CartSuccessState,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(20),
                        itemCount: books.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return CartCard(
                            book: books[index],
                            onRemove: () {
                              cubit.removeFromCart(
                                cartItemId: books[index].itemId ?? 0,
                              );
                            },
                            onRefresh: () {
                              cubit.getCart();
                            },
                            onUpdate: (q) {
                              cubit.updateQuantity(
                                cartItemId: books[index].itemId ?? 0,
                                quantity: q,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text('Total:', style: TextStyles.styleSize18),
                              const Spacer(),
                              Text(
                                '${cubit.cartResponse?.data?.total}',
                                style: TextStyles.styleSize18,
                              ),
                            ],
                          ),
                          const Gap(10),
                          MainButton(
                            label: 'Checkout',
                            onPressed: () {
                              cubit.checkout();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
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
            AppImages.cartSvg,
            width: 100,
            colorFilter: const ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          Gap(20),
          Text('No books in cart', style: TextStyles.styleSize16),
        ],
      ),
    );
  }
}
