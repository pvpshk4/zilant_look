import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_event.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPhotoListVisible = false;

  @override
  void initState() {
    super.initState();
    // Загружаем данные приложения при инициализации страницы
    context.read<AppDataBloc>().add(LoadAppDataEvent());
  }

  void _togglePhotoList() {
    setState(() {
      _isPhotoListVisible = !_isPhotoListVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Основной контент
          Column(
            children: [
              // Верхняя часть с кнопкой (без слайдера)
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color:
                            _isPhotoListVisible
                                ? Colors.purple
                                : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color:
                              _isPhotoListVisible
                                  ? Colors.white
                                  : Colors.purple,
                          size: 30,
                        ),
                        onPressed: _togglePhotoList,
                      ),
                    ),
                  ],
                ),
              ),
              // Основной контент (заглушка)
              const Expanded(
                child: Center(
                  child: Text(
                    'Основной контент будет здесь',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
          // Слайдер с фотографиями (накладывается поверх)
          if (_isPhotoListVisible)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black.withValues(alpha: 50), // Полупрозрачный фон
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 56,
                        ), // Отступ для кнопки (16 padding + 40 иконка)
                        Expanded(
                          child: SizedBox(
                            height: 100, // Высота слайдера
                            child: BlocBuilder<AppDataBloc, AppDataState>(
                              builder: (context, state) {
                                if (state.isLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final photos = state.humanPhotos;
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  itemCount:
                                      photos.length +
                                      1, // +1 для кнопки добавления
                                  itemBuilder: (context, index) {
                                    if (index == photos.length) {
                                      // Кнопка добавления
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Card(
                                          elevation: 4,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              context.push(
                                                '/upload-human-photo',
                                              );
                                              setState(() {
                                                _isPhotoListVisible = false;
                                              });
                                            },
                                            child: Container(
                                              width: 80,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    // Фотография человека
                                    final photo = photos[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: Image.memory(
                                            base64Decode(
                                              photo.contains(',')
                                                  ? photo.split(',').last
                                                  : photo,
                                            ),
                                            width: 80,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder: (
                                              context,
                                              error,
                                              stackTrace,
                                            ) {
                                              return const Icon(Icons.error);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        // Кнопка закрытия списка
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.grey),
                          onPressed: _togglePhotoList,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
