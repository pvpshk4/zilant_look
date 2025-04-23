import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_event.dart';
import '../bloc/photo_upload_state.dart';
import '../widgets/custom_check_box.dart';

class HumanPhotoPreviewPage extends StatefulWidget {
  final String imagePath;

  const HumanPhotoPreviewPage({super.key, required this.imagePath});

  @override
  State<HumanPhotoPreviewPage> createState() => _HumanPhotoPreviewPageState();
}

class _HumanPhotoPreviewPageState extends State<HumanPhotoPreviewPage> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhotoUploadBloc, PhotoUploadState>(
      listener: (context, state) {
        if (state is PhotoUploadSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Фото успешно загружено')),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is PhotoUploadFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child:
                    state is PhotoUploadSuccessState
                        ? Image.memory(
                          base64Decode(state.photo.image),
                          fit: BoxFit.cover,
                        )
                        : Image.file(File(widget.imagePath), fit: BoxFit.cover),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    context.read<PhotoUploadBloc>().add(
                      CancelPhotoUploadEvent(),
                    );
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    'assets/icons/arrow_back_circled.svg',
                    width: 46,
                    height: 46,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: CustomCheckBox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
              ),
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Center(
                  child:
                      state is PhotoUploadLoadingState
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                            onPressed:
                                _isChecked
                                    ? () => context.read<PhotoUploadBloc>().add(
                                      SavePhotoEvent(context),
                                    )
                                    : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            child: const Text(
                              'Загрузить',
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'SFPro-Medium',
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
