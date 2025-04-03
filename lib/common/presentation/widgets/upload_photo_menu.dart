import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';

class UploadPhotoMenu extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onUploadPhoto;
  final VoidCallback onAddClothingPhoto;

  const UploadPhotoMenu({
    super.key,
    required this.isExpanded,
    required this.onUploadPhoto,
    required this.onAddClothingPhoto,
  });

  @override
  Widget build(BuildContext context) {
    final bottomBarHeight = kBottomNavigationBarHeight; // Высота нижней панели

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      bottom:
          isExpanded
              ? bottomBarHeight - 60
              : -160, // Появляется над BottomNavigationBar
      left: 0,
      right: 0,
      child: Material(
        elevation: 4,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        color: AppColors.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: onUploadPhoto,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppColors.buttonColor,
                ),
                child: const Text(
                  "Загрузить свое фото",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: onAddClothingPhoto,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: AppColors.buttonColor,
                ),
                child: const Text(
                  "Добавить фото одежды",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
