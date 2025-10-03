import 'package:bookia/features/home/data/models/best_seller_response/best_seller_response.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/data/models/slider_response/slider.dart';
import 'package:bookia/features/home/data/models/slider_response/slider_response.dart';
import 'package:bookia/features/home/data/repo/home_repo.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<Product> products = [
    Product(),
    Product(),
    Product(),
    Product(),
    Product(),
  ];

  List<SliderModel> sliders = [SliderModel(), SliderModel(), SliderModel()];

  fetchHomeData() async {
    emit(HomeLoadingState());

    try {
      final sliderFuture = HomeRepo.getSlider();
      final bestSellerFuture = HomeRepo.getBestSeller();

      final results = await Future.wait([sliderFuture, bestSellerFuture]);

      final slider = results[0] as SliderResponse?;
      final bestSeller = results[1] as BestSellerResponse?;

      if (slider != null || bestSeller != null) {
        sliders = slider?.data?.sliders ?? [];
        products = bestSeller?.data?.products ?? [];

        emit(HomeSuccessState()); // to rebuild ui
      } else {
        emit(HomeErrorState());
      }
    } catch (e) {
      emit(HomeErrorState());
    }
  }
}
