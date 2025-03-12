import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoPickerWidget extends StatelessWidget {
  final Function(String) onPhotoSelected;

  const PhotoPickerWidget({super.key, required this.onPhotoSelected});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        final imagePicker = ImagePicker();
        final pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile != null) {
          onPhotoSelected(pickedFile.path);
        }
      },
      child: Icon(Icons.add_a_photo),
    );
  }
}
