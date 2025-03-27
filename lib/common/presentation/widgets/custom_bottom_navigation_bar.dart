import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.secondaryColor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      iconSize: 28,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/home_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 0
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
          label: 'Главная',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/catalog_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 1
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              BlendMode.srcIn,
            ),
            width: 22,
            height: 22,
          ),
          label: 'Каталог',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/wardrobe_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 2
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              BlendMode.srcIn,
            ),
            width: 24,
            height: 24,
          ),
          label: 'Гардероб',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/icons/profile_icon.svg',
            colorFilter: ColorFilter.mode(
              currentIndex == 3
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              BlendMode.srcIn,
            ),
            width: 20,
            height: 20,
          ),
          label: 'Профиль',
        ),
      ],
    );
  }
}
