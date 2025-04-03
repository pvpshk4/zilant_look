import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme/app_colors.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/upload_photo_menu.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final List<String> routes;
  final bool showFloatingButton;

  const MainLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.routes,
    required this.showFloatingButton,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late int _currentIndex;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _isExpanded = false;
      });
      context.go(widget.routes[index]);
    }
  }

  void _toggleUploadMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _navigateToUploadPhoto() {
    setState(() => _isExpanded = false);
    context.go('/upload-human-photo');
  }

  void _navigateToAddClothingPhoto() {
    setState(() => _isExpanded = false);
    context.go('/upload-clothes-photo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          if (_isExpanded && widget.showFloatingButton)
            UploadPhotoMenu(
              isExpanded: _isExpanded,
              onUploadPhoto: _navigateToUploadPhoto,
              onAddClothingPhoto: _navigateToAddClothingPhoto,
            ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          widget.showFloatingButton
              ? Padding(
                padding: const EdgeInsets.only(top: 40),
                child: FloatingActionButton(
                  onPressed: _toggleUploadMenu,
                  backgroundColor: AppColors.buttonColor,
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              )
              : null,
    );
  }
}
