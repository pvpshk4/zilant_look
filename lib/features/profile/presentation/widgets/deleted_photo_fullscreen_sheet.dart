import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zilant_look/config/theme/app_colors.dart';

class DeletedPhotoFullscreenSheet extends StatefulWidget {
  final String photo;
  final VoidCallback onRestore;
  final VoidCallback onDelete;

  const DeletedPhotoFullscreenSheet({
    super.key,
    required this.photo,
    required this.onRestore,
    required this.onDelete,
  });

  @override
  State<DeletedPhotoFullscreenSheet> createState() =>
      _DeletedPhotoFullscreenSheetState();
}

class _DeletedPhotoFullscreenSheetState
    extends State<DeletedPhotoFullscreenSheet> {
  late final Uint8List imageBytes;

  @override
  void initState() {
    super.initState();
    final base64String =
        widget.photo.contains(',')
            ? widget.photo.split(',').last
            : widget.photo;
    imageBytes = base64Decode(base64String);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final offset = screenHeight * 0.01;

    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Transform.translate(
                  offset: Offset(0, -offset - 8),
                  child: Container(
                    width: 230,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: offset * 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.memory(
                      imageBytes,
                      fit: BoxFit.contain,
                      width: double.infinity,
                      height: screenHeight * 0.5,
                      errorBuilder:
                          (context, error, stackTrace) => Container(
                            color: AppColors.greyColor,
                            height: screenHeight * 0.5,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                              size: 50,
                            ),
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: InkWell(
                          onTap: widget.onDelete,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/trash_can_icon.svg',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: widget.onRestore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                          ),
                          child: const Text(
                            'Восстановить',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'SFPro-Bold',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
