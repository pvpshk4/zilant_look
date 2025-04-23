import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_event.dart';
import '../bloc/photo_upload_state.dart';
import 'human_photo_preview_page.dart';

class CameraPage extends StatelessWidget {
  final bool isClothesUpload;

  const CameraPage({super.key, required this.isClothesUpload});

  @override
  Widget build(BuildContext context) {
    context.read<PhotoUploadBloc>().add(SetUploadTypeEvent(isClothesUpload));
    return BlocListener<PhotoUploadBloc, PhotoUploadState>(
      listener: (context, state) {
        if (state is PhotoUploadAwaitingCategoryState) {
          context.push(
            '/upload-clothes-photo/category-selection',
            extra: state.imagePath,
          );
        } else if (state is PhotoUploadPreviewState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => HumanPhotoPreviewPage(imagePath: state.imagePath),
            ),
          );
        }
        // Убираем обработку PhotoUploadSuccessState и PhotoUploadFailureState
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Чёрный фон для камеры (заглушка)
            Positioned.fill(
              child: GestureDetector(
                onTap:
                    () => context.read<PhotoUploadBloc>().add(
                      TakePhotoFromCameraEvent(),
                    ),
                child: Container(color: Colors.black),
              ),
            ),
            // Кнопка "Назад" в левом верхнем углу
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  'assets/icons/arrow_back_circled.svg',
                  width: 32,
                  height: 32,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            // Кнопка для съёмки в центре снизу
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap:
                      () => context.read<PhotoUploadBloc>().add(
                        TakePhotoFromCameraEvent(),
                      ),
                  child: SvgPicture.asset(
                    'assets/icons/camera_circle.svg',
                    width: 72,
                    height: 72,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            // Кнопка для выбора из галереи в правом нижнем углу
            Positioned(
              bottom: 60,
              right: 40,
              child: GestureDetector(
                onTap:
                    () => context.read<PhotoUploadBloc>().add(
                      ChoosePhotoFromGalleryEvent(),
                    ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.folder_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                    Text(
                      'Галерея',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'SFPro-Light',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
