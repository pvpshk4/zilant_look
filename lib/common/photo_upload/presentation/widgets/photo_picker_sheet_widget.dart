import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../pages/photo_upload_page.dart';

class PhotoPickerSheetWidget extends StatelessWidget {
  final UploadType uploadType;
  final Function(String) onPhotoSelected;

  const PhotoPickerSheetWidget({
    super.key,
    required this.uploadType,
    required this.onPhotoSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          uploadType == UploadType.human
              ? 'Загрузить фото человека'
              : 'Добавить одежду',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        _buildPickerButton(
          'Сделать фото',
          Icons.camera_alt,
          () => _pickImage(ImageSource.camera, context),
        ),
        _buildPickerButton(
          'Выбрать из галереи',
          Icons.photo_library,
          () => _pickImage(ImageSource.gallery, context),
        ),
      ],
    );
  }

  Widget _buildPickerButton(String text, IconData icon, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(text), onTap: onTap);
  }

  void _pickImage(ImageSource source, BuildContext context) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) onPhotoSelected(image.path);
  }
}
