import 'dart:io';
import 'package:flutter/material.dart';

class PhotoPreviewWidget extends StatelessWidget {
  final String imagePath;

  const PhotoPreviewWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.55,
      height: screenHeight * 0.58,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Image.file(File(imagePath), fit: BoxFit.cover),
    );
  }
}
