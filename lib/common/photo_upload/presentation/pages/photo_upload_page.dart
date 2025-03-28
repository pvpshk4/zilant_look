import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_bloc.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_event.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_state.dart';
import 'package:zilant_look/injection_container.dart';

class PhotoUploadPage extends StatelessWidget {
  const PhotoUploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PhotoUploadBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Photo'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).go('/');
            },
          ),
        ),
        body: BlocConsumer<PhotoUploadBloc, PhotoUploadState>(
          listener: (context, state) {
            if (state is PhotoUploadFailureState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is PhotoUploadLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PhotoUploadSuccessState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(File(state.photo.imageBase64)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PhotoUploadBloc>().add(
                          TakePhotoFromCameraEvent(
                            username: 'your_username',
                            subcategory: 'upper_body',
                          ),
                        );
                      },
                      child: const Text('Take Another Photo'),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<PhotoUploadBloc>().add(
                        TakePhotoFromCameraEvent(
                          username: 'your_username',
                          subcategory: 'upper_body',
                        ),
                      );
                    },
                    child: const Text('Take Photo from Camera'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<PhotoUploadBloc>().add(
                        ChoosePhotoFromGalleryEvent(
                          username: 'your_username',
                          subcategory: 'upper_body',
                        ),
                      );
                    },
                    child: const Text('Choose Photo from Gallery'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
