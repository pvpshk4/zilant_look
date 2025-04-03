import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('home_icon.svg', 'Главная', 0, size: 24),
          _buildNavItem('catalog_icon.svg', 'Каталог', 1, size: 20),
          const SizedBox(),
          _buildNavItem('wardrobe_icon.svg', 'Гардероб', 2, size: 24),
          _buildNavItem('profile_icon.svg', 'Профиль', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    String icon,
    String label,
    int index, {
    double size = 22,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/$icon',
            width: size,
            height: size,
            colorFilter: ColorFilter.mode(
              index == currentIndex
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
              BlendMode.srcIn,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontFamily: 'SFPro-Medium'),
          ),
        ],
      ),
    );
  }
}
