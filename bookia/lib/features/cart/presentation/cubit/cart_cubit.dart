import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_response.dart';
import 'package:bookia/features/cart/data/models/cart_response/data.dart';
import 'package:bookia/features/cart/data/models/place_order_params.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final governorateController = TextEditingController();

  int selectedGovernorateId = -1;

  CartResponse? cartResponse = CartResponse(
    data: Data(cartItems: [CartItem(), CartItem(), CartItem()]),
  );

  getCart() async {
    emit(CartLoadingState());
    var res = await CartRepo.getCart();

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  removeFromCart({required int cartItemId}) async {
    emit(CartLoadingState());
    var res = await CartRepo.removeFromCart(cartItemId: cartItemId);

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  updateQuantity({required int cartItemId, required int quantity}) async {
    // emit(CartLoadingState());
    var res = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );

    if (res != null) {
      cartResponse = res;
      emit(CartSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  checkout() async {
    emit(CheckoutLoadingState());
    var res = await CartRepo.checkout();

    if (res) {
      emit(CheckoutSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  placeOrder() async {
    emit(CheckoutLoadingState());
    var params = PlaceOrderParams(
      name: fullNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      address: addressController.text,
      governorateId: selectedGovernorateId,
    );
    var res = await CartRepo.placeOrder(params);

    if (res) {
      emit(CheckoutSuccessState());
    } else {
      emit(CartErrorState());
    }
  }

  prefillOrder() {
    var user = SharedPref.getUserData();
    fullNameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
    addressController.text = user?.address ?? "";
    phoneController.text = user?.phone ?? "";
  }
}
