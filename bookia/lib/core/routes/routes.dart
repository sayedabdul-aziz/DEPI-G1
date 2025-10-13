import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/register_screen.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/page/place_order_screen.dart';
import 'package:bookia/features/home/data/models/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/page/details_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/features/splash/splash_screen.dart';
import 'package:bookia/features/welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String details = '/details';
  static const String placeOrder = '/placeOrder';
  static const String editProfile = '/editProfile';

  static final routes = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: welcome, builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: main,
        builder: (context, state) {
          return MainAppScreen();
        },
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: DetailsScreen(product: state.extra as Product),
          );
        },
      ),
      GoRoute(
        path: placeOrder,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => CartCubit()..prefillOrder(),
            child: PlaceOrderScreen(total: state.extra as String),
          );
        },
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => ProfileCubit()..initData(),
            child: EditProfileScreen(),
          );
        },
      ),
    ],
  );
}
