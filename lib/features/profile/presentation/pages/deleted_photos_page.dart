import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_event.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_state.dart';
import 'package:zilant_look/common/presentation/dialogs/permanent_delete_confirmation_dialog.dart';
import 'package:zilant_look/common/presentation/dialogs/restore_confirmation_dialog.dart';
import 'package:zilant_look/config/theme/app_colors.dart';
import '../widgets/deleted_photo_fullscreen_sheet.dart';
import '../widgets/photo_grid.dart';

class DeletedPhotosPage extends StatelessWidget {
  const DeletedPhotosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<AppDataBloc, AppDataState>(
          builder: (context, state) {
            final allSelected =
                state.selectedDeletedPhotos.length ==
                    state.deletedPhotos.length &&
                state.deletedPhotos.isNotEmpty;

            return AppBar(
              leading:
                  state.selectedDeletedPhotos.isNotEmpty
                      ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed:
                            () => context.read<AppDataBloc>().add(
                              ClearSelectionEvent(isDeletedPhotos: true),
                            ),
                      )
                      : IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
              title: const Text(
                'Удалённые фото',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SFPro-Medium',
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              actions:
                  state.selectedDeletedPhotos.isNotEmpty
                      ? [
                        TextButton(
                          onPressed: () {
                            if (allSelected) {
                              context.read<AppDataBloc>().add(
                                ClearSelectionEvent(isDeletedPhotos: true),
                              );
                            } else {
                              context.read<AppDataBloc>().add(
                                SelectAllPhotosEvent(
                                  state.deletedPhotos
                                      .map((photo) => photo.imageBase64)
                                      .toList(),
                                  isDeletedPhotos: true,
                                ),
                              );
                            }
                          },
                          child: Text(
                            allSelected ? 'Снять выделение' : 'Выбрать все',
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontFamily: 'SFPro-Light',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ]
                      : null,
            );
          },
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    BlocBuilder<AppDataBloc, AppDataState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state.deletedPhotos.isEmpty) {
                          return const Center(
                            child: Text(
                              'Нет удалённых фотографий',
                              style: TextStyle(
                                fontFamily: 'SFPro-Medium',
                                fontSize: 18,
                              ),
                            ),
                          );
                        }
                        final photos =
                            state.deletedPhotos
                                .map((photo) => photo.imageBase64)
                                .toList();
                        return PhotoGrid(
                          photos: photos,
                          isDeletedPhotos: true,
                          selectedPhotos: state.selectedDeletedPhotos,
                          onPhotoTapped: (photo) {
                            if (state.selectedDeletedPhotos.isNotEmpty) {
                              if (state.selectedDeletedPhotos.contains(photo)) {
                                context.read<AppDataBloc>().add(
                                  DeselectPhotoEvent(
                                    photo,
                                    isDeletedPhotos: true,
                                  ),
                                );
                              } else {
                                context.read<AppDataBloc>().add(
                                  SelectPhotoEvent(
                                    photo,
                                    isDeletedPhotos: true,
                                  ),
                                );
                              }
                            } else {
                              _showFullscreenSheet(context, photo);
                            }
                          },
                          onPhotoLongPressed: (photo) {
                            context.read<AppDataBloc>().add(
                              SelectPhotoEvent(photo, isDeletedPhotos: true),
                            );
                          },
                          onDelete: (photo) {
                            showDialog(
                              context: context,
                              builder:
                                  (dialogContext) =>
                                      PermanentDeleteConfirmationDialog(
                                        onConfirm: () {
                                          context.read<AppDataBloc>().add(
                                            PermanentlyDeletePhotosEvent([
                                              photo,
                                            ]),
                                          );
                                          Navigator.pop(dialogContext);
                                        },
                                        onCancel:
                                            () => Navigator.pop(dialogContext),
                                      ),
                            );
                          },
                          onRestore: (photo) {
                            showDialog(
                              context: context,
                              builder:
                                  (dialogContext) => RestoreConfirmationDialog(
                                    onConfirm: () {
                                      context.read<AppDataBloc>().add(
                                        RestorePhotosEvent([photo]),
                                      );
                                      Navigator.pop(dialogContext);
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Фотография восстановлена',
                                          ),
                                        ),
                                      );
                                    },
                                    onCancel:
                                        () => Navigator.pop(dialogContext),
                                  ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<AppDataBloc, AppDataState>(
              builder: (context, state) {
                if (state.selectedDeletedPhotos.isNotEmpty) {
                  return Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Card(
                                elevation: 4.0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (
                                            dialogContext,
                                          ) => PermanentDeleteConfirmationDialog(
                                            onConfirm: () {
                                              context.read<AppDataBloc>().add(
                                                PermanentlyDeletePhotosEvent(
                                                  state.selectedDeletedPhotos
                                                      .toList(),
                                                ),
                                              );
                                              context.read<AppDataBloc>().add(
                                                ClearSelectionEvent(
                                                  isDeletedPhotos: true,
                                                ),
                                              );
                                              Navigator.pop(dialogContext);
                                            },
                                            onCancel:
                                                () => Navigator.pop(
                                                  dialogContext,
                                                ),
                                          ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SvgPicture.asset(
                                      'assets/icons/trash_can_icon.svg',
                                      width: 26,
                                      height: 26,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16.0),
                              SizedBox(
                                width: 325.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18.0,
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder:
                                          (
                                            dialogContext,
                                          ) => RestoreConfirmationDialog(
                                            onConfirm: () {
                                              context.read<AppDataBloc>().add(
                                                RestorePhotosEvent(
                                                  state.selectedDeletedPhotos
                                                      .toList(),
                                                ),
                                              );
                                              context.read<AppDataBloc>().add(
                                                ClearSelectionEvent(
                                                  isDeletedPhotos: true,
                                                ),
                                              );
                                              Navigator.pop(dialogContext);
                                            },
                                            onCancel:
                                                () => Navigator.pop(
                                                  dialogContext,
                                                ),
                                          ),
                                    );
                                  },
                                  child: const Text(
                                    'Восстановить',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: 'SFPro-Bold',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFullscreenSheet(BuildContext context, String photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (sheetContext) => DeletedPhotoFullscreenSheet(
            photo: photo,
            onRestore: () {
              showDialog(
                context: sheetContext,
                builder:
                    (dialogContext) => RestoreConfirmationDialog(
                      onConfirm: () {
                        sheetContext.read<AppDataBloc>().add(
                          RestorePhotosEvent([photo]),
                        );
                        Navigator.pop(dialogContext);
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                          const SnackBar(
                            content: Text('Фотография восстановлена'),
                          ),
                        );
                      },
                      onCancel: () => Navigator.pop(dialogContext),
                    ),
              );
            },
            onDelete: () {
              showDialog(
                context: sheetContext,
                builder:
                    (dialogContext) => PermanentDeleteConfirmationDialog(
                      onConfirm: () {
                        final state = sheetContext.read<AppDataBloc>().state;
                        if (state.deletedPhotos
                            .map((p) => p.imageBase64)
                            .contains(photo)) {
                          sheetContext.read<AppDataBloc>().add(
                            PermanentlyDeletePhotosEvent([photo]),
                          );
                        }
                        Navigator.pop(dialogContext);
                        Navigator.pop(sheetContext);
                        ScaffoldMessenger.of(sheetContext).showSnackBar(
                          const SnackBar(content: Text('Фотография удалена')),
                        );
                      },
                      onCancel: () => Navigator.pop(dialogContext),
                    ),
              );
            },
          ),
    );
  }
}
