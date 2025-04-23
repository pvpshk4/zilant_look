import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme/app_colors.dart';
import '../widgets/custom_bottom_navigation_bar.dart';

class MainLayout extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final bool showFloatingButton;
  final bool showBottomNavBar;

  const MainLayout({
    super.key,
    required this.navigationShell,
    required this.showFloatingButton,
    required this.showBottomNavBar,
  });

  void _onItemTapped(BuildContext context, int index) {
    navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell, // Используем navigationShell для отображения текущей страницы
        ],
      ),
      bottomNavigationBar:
          showBottomNavBar
              ? CustomBottomNavigationBar(
                currentIndex: navigationShell.currentIndex,
                onTap: (index) => _onItemTapped(context, index),
                backgroundColor: Colors.white,
                activeTextColor: AppColors.primaryColor,
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          showFloatingButton
              ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: FloatingActionButton(
                  elevation: 10,
                  onPressed: () => context.push('/upload-clothes-photo'),
                  backgroundColor: AppColors.buttonColor,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              )
              : null,
    );
  }
}
