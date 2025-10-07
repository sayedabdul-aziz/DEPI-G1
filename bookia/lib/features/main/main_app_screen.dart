import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/presentation/page/home_screen.dart';
import 'package:bookia/features/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int selectedIndex = 0;
  List<Widget> pages = [
    HomeScreen(),
    WishlistScreen(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          _buildNavbarItem(path: AppImages.homeSvg, label: 'Home'),
          _buildNavbarItem(path: AppImages.bookmarkSvg, label: 'Bookmark'),
          _buildNavbarItem(path: AppImages.cartSvg, label: 'Cart'),
          _buildNavbarItem(path: AppImages.profileSvg, label: 'Profile'),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavbarItem({
    required String path,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        path,
        colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
      ),
      icon: SvgPicture.asset(path),
      label: label,
    );
  }
}
