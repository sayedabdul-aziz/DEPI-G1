import 'package:bookia/core/helper/app_regex.dart';
import 'package:bookia/core/routes/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/core/widgets/app_bar_with_back.dart';
import 'package:bookia/core/widgets/custom_text_form_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/cart/data/models/governorates.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatelessWidget {
  const PlaceOrderScreen({super.key, required this.total});
  final String total;

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CartCubit>();

    return Scaffold(
      appBar: AppBarWithBack(),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CheckoutSuccessState) {
            pop(context);
            pushToBase(context, Routes.main);
          } else if (state is CheckoutLoadingState) {
            showLoadingDialog(context);
          } else if (state is CheckoutErrorState) {
            pop(context);
            showMyDialog(context, 'something went wrong');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Place Your Order', style: TextStyles.styleSize30),
                  Gap(10),
                  Text(
                    'Don\'t worry! It occurs. Please enter the email address linked with your account.',
                    style: TextStyles.styleSize16.copyWith(
                      color: AppColors.greyColor,
                    ),
                  ),
                  Gap(25),
                  CustomTextFormField(
                    controller: cubit.fullNameController,
                    hintText: 'Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextFormField(
                    controller: cubit.emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!AppRegex.isEmailValid(value)) {
                        return 'Please enter a valid address';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextFormField(
                    controller: cubit.addressController,
                    hintText: 'Address',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextFormField(
                    controller: cubit.phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    hintText: 'Phone',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone';
                      } else if (!AppRegex.isEgyptMobile(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomTextFormField(
                    controller: cubit.governorateController,
                    hintText: 'Governorate',
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.primaryColor,
                    ),
                    readOnly: true,
                    onTap: () {
                      selectGovernorate(context, cubit);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your governorate';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text('Total:', style: TextStyles.styleSize18),
                  const Spacer(),
                  Text(total, style: TextStyles.styleSize18),
                ],
              ),
              const Gap(10),
              MainButton(
                label: 'Place Order',
                onPressed: () {
                  if (cubit.formKey.currentState!.validate()) {
                    cubit.placeOrder();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  selectGovernorate(BuildContext context, CartCubit cubit) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),
              Text('Select Governorate', style: TextStyles.styleSize20),
              Gap(10),
              Divider(),
              Gap(10),
              Expanded(
                child: ListView.separated(
                  itemCount: governorate.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () {
                        pop(context);
                        cubit.selectedGovernorateId =
                            governorate[index].id ?? -1;
                        cubit.governorateController.text =
                            governorate[index].governorateNameEn ?? '';
                      },
                      leading: Icon(
                        Icons.location_on,
                        color: AppColors.primaryColor,
                      ),
                      title: Text(governorate[index].governorateNameEn ?? ''),
                      trailing:
                          cubit.selectedGovernorateId == governorate[index].id
                          ? Icon(Icons.check, color: AppColors.primaryColor)
                          : null,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
