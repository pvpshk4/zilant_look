import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_event.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zilant_look/config/theme/app_colors.dart';
import '../../../../common/presentation/dialogs/confirmation_dialog.dart';
import '../widgets/photo_grid.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppDataBloc, AppDataState>(
      builder: (context, appDataState) {
        final allSelected =
            appDataState.selectedHumanPhotos.length ==
                appDataState.humanPhotos.length &&
            appDataState.humanPhotos.isNotEmpty;

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading:
                appDataState.selectedHumanPhotos.isNotEmpty
                    ? IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed:
                          () => context.read<AppDataBloc>().add(
                            ClearSelectionEvent(isDeletedPhotos: false),
                          ),
                    )
                    : null,
            title: const Text(
              'Профиль',
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
                appDataState.selectedHumanPhotos.isNotEmpty
                    ? [
                      TextButton(
                        onPressed: () {
                          if (allSelected) {
                            context.read<AppDataBloc>().add(
                              ClearSelectionEvent(isDeletedPhotos: false),
                            );
                          } else {
                            context.read<AppDataBloc>().add(
                              SelectAllPhotosEvent(
                                appDataState.humanPhotos,
                                isDeletedPhotos: false,
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
                        const Text(
                          'Мои фото',
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SFPro-SemiBold',
                          ),
                        ),
                        const SizedBox(height: 10),
                        if (appDataState.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (appDataState.humanPhotos.isEmpty)
                          const Center(
                            child: Text(
                              'Нет фотографий',
                              style: TextStyle(
                                fontFamily: 'SFPro-Light',
                                fontSize: 18,
                              ),
                            ),
                          )
                        else
                          PhotoGrid(
                            photos: appDataState.humanPhotos,
                            isDeletedPhotos: false,
                            selectedPhotos: appDataState.selectedHumanPhotos,
                            onPhotoTapped: (photo) {
                              if (appDataState.selectedHumanPhotos.contains(
                                photo,
                              )) {
                                context.read<AppDataBloc>().add(
                                  DeselectPhotoEvent(
                                    photo,
                                    isDeletedPhotos: false,
                                  ),
                                );
                              } else {
                                context.read<AppDataBloc>().add(
                                  SelectPhotoEvent(
                                    photo,
                                    isDeletedPhotos: false,
                                  ),
                                );
                              }
                            },
                            onPhotoLongPressed: (photo) {
                              context.read<AppDataBloc>().add(
                                SelectPhotoEvent(photo, isDeletedPhotos: false),
                              );
                            },
                            onDelete: (photo) {
                              showDialog(
                                context: context,
                                builder:
                                    (dialogContext) => ConfirmationDialog(
                                      onConfirm: () {
                                        context.read<AppDataBloc>().add(
                                          DeletePhotosEvent([photo]),
                                        );
                                        Navigator.pop(dialogContext);
                                      },
                                      onCancel:
                                          () => Navigator.pop(dialogContext),
                                    ),
                              );
                            },
                            onSetPhoto: (photo) {
                              context.read<AppDataBloc>().add(
                                SetSelectedPhotoEvent(photo),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Фотография установлена'),
                                ),
                              );
                            },
                          ),
                        const SizedBox(height: 7),
                        GestureDetector(
                          onTap: () => context.push('/profile/deleted-photos'),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 16.0,
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 7.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withAlpha(90),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/trash_can_icon.svg',
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Удалённые',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'SFPro-SemiBold',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (appDataState.selectedHumanPhotos.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 25.0,
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SizedBox(
                            width: double.infinity,
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
                                      (dialogContext) => ConfirmationDialog(
                                        onConfirm: () {
                                          context.read<AppDataBloc>().add(
                                            DeletePhotosEvent(
                                              appDataState.selectedHumanPhotos
                                                  .toList(),
                                            ),
                                          );
                                          context.read<AppDataBloc>().add(
                                            ClearSelectionEvent(
                                              isDeletedPhotos: false,
                                            ),
                                          );
                                          Navigator.pop(dialogContext);
                                        },
                                        onCancel:
                                            () => Navigator.pop(dialogContext),
                                      ),
                                );
                              },
                              child: const Text(
                                'Удалить',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'SFPro-Bold',
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
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
