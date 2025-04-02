import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_event.dart';
// Импортируем UploadType из photo_upload_page.dart, чтобы не было дублирования
import '../pages/photo_upload_page.dart';

class PhotoPickerWidget extends StatelessWidget {
  final UploadType uploadType;

  const PhotoPickerWidget({super.key, required this.uploadType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.camera_alt),
          onPressed: () {
            context.read<PhotoUploadBloc>().add(
              const TakePhotoFromCameraEvent(),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.photo_library),
          onPressed: () {
            context.read<PhotoUploadBloc>().add(
              const ChoosePhotoFromGalleryEvent(),
            );
          },
        ),
      ],
    );
  }
}
