import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/config/theme/app_colors.dart';

import '../../../../common/photo_upload/presentation/pages/camera_page.dart';

class PhotoListWidget extends StatefulWidget {
  final VoidCallback onClose;
  final Function(String?) onPhotoSelected;

  const PhotoListWidget({
    super.key,
    required this.onClose,
    required this.onPhotoSelected,
  });

  @override
  State<PhotoListWidget> createState() => _PhotoListWidgetState();
}

class _PhotoListWidgetState extends State<PhotoListWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.7, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _scaleAnimation = Tween<double>(
      begin: 0.4,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void closeWidgetWithAnimation() {
    _controller.reverse().then((_) => widget.onClose());
  }

  @override
  Widget build(BuildContext context) {
    final photos = context.read<AppDataBloc>().state.humanPhotos;

    return Positioned(
      top: 10,
      left: 65,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return ScaleTransition(
            scale: _scaleAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(100),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 100,
                        width:
                            MediaQuery.of(context).size.width - (16 + 42 + 24),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          itemCount: photos.length + 1,
                          itemBuilder: (context, index) {
                            if (index == photos.length) {
                              return _buildAddPhotoButton(context);
                            }
                            final photo = photos[index];
                            return _buildPhotoItem(photo, index);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAddPhotoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          closeWidgetWithAnimation();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CameraPage(isClothesUpload: false);
            },
          );
        },
        child: Container(
          width: 70,
          height: 90,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  Widget _buildPhotoItem(String base64Photo, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: () {
          widget.onPhotoSelected(base64Photo);
          closeWidgetWithAnimation();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.memory(
            base64Decode(
              base64Photo.contains(',')
                  ? base64Photo.split(',').last
                  : base64Photo,
            ),
            width: 70,
            height: 90,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
      ),
    );
  }
}
