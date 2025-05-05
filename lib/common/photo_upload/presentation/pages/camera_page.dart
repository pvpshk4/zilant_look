import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/clothes_category_selection_page.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/human_photo_preview_page.dart';
import '../../../../core/resources/dialog_state.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_event.dart';
import '../bloc/photo_upload_state.dart';

class CameraPage extends StatefulWidget {
  final bool isClothesUpload;

  const CameraPage({super.key, required this.isClothesUpload});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      DialogState.setActiveDialog(ActiveDialog.camera);
      context.read<PhotoUploadBloc>().add(ResetPhotoUploadEvent());
      context.read<PhotoUploadBloc>().add(
        SetUploadTypeEvent(widget.isClothesUpload),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: EdgeInsets.zero,
      child: BlocListener<PhotoUploadBloc, PhotoUploadState>(
        listener: (context, state) {
          if (state is PhotoUploadAwaitingCategoryState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ClothesCategorySelectionPage(
                      imagePath: state.imagePath,
                    ),
              ),
            );
          } else if (state is PhotoUploadPreviewState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return HumanPhotoPreviewPage(imagePath: state.imagePath);
              },
            );
          } else if (state is PhotoUploadResetState) {
            DialogState.setActiveDialog(ActiveDialog.none);
            Navigator.of(context).pop();
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap:
                    () => context.read<PhotoUploadBloc>().add(
                      TakePhotoFromCameraEvent(),
                    ),
                child: Container(color: Colors.black),
              ),
            ),
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  context.read<PhotoUploadBloc>().add(CancelPhotoUploadEvent());
                },
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
