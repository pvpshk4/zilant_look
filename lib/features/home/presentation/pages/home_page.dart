import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/features/home/presentation/bloc/home_bloc.dart';
import 'package:zilant_look/features/home/presentation/bloc/home_event.dart';

import '../../../../injection_container.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(LoadHomeContentEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Главная')),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.content.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SFPro-Semibold',
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      state.content.description,
                      style: TextStyle(fontFamily: 'SFPro-Medium'),
                    ),
                  ],
                ),
              );
            } else if (state is HomeErrorState) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
