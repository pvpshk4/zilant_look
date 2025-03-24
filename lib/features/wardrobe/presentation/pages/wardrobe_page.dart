import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_bloc.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_event.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_state.dart';

import '../widgets/wardrobe_item_widget.dart';

class WardrobePage extends StatelessWidget {
  const WardrobePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wardrobe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              context.read<WardrobeBloc>().add(
                FilterWardrobeByCategoryEvent('someCategory'),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<WardrobeBloc, WardrobeState>(
        builder: (context, state) {
          if (state is WardrobeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WardrobeLoadedState) {
            final items = state.items;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return WardrobeItemWidget(
                  item: item,
                  onDelete: () {
                    context.read<WardrobeBloc>().add(
                      DeleteClothingItemEvent(item.id),
                    );
                  },
                );
              },
            );
          } else if (state is WardrobeErrorState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No items found'));
        },
      ),
    );
  }
}
