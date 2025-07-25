import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../config/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color activeTextColor;
  final bool showCentralButton;
  final VoidCallback onCentralButtonTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = Colors.white,
    this.activeTextColor = AppColors.primaryColor,
    required this.showCentralButton,
    required this.onCentralButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        color: backgroundColor,
        height: 73,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('home_icon.svg', 'Главная', 0, size: 24),
            _buildNavItem('catalog_icon.svg', 'Каталог', 1, size: 20),
            showCentralButton
                ? Transform.translate(
                  offset: const Offset(0, -3),
                  child: GestureDetector(
                    onTap: onCentralButtonTap,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                )
                : const SizedBox(width: 60),
            _buildNavItem('wardrobe_icon.svg', 'Гардероб', 2, size: 24),
            _buildNavItem('profile_icon.svg', 'Профиль', 3),
          ],
        ),
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
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'SFPro-Medium',
              color:
                  index == currentIndex
                      ? activeTextColor
                      : AppColors.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
