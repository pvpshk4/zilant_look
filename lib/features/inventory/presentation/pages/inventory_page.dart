import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/features/inventory/presentation/bloc/inventory_bloc.dart';
import 'package:zilant_look/features/inventory/presentation/bloc/inventory_event.dart';
import 'package:zilant_look/features/inventory/presentation/bloc/inventory_state.dart';

import '../widgets/inventory_item_widget.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              context.read<InventoryBloc>().add(
                FilterInventoryByCategoryEvent('someCategory'),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<InventoryBloc, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InventoryLoadedState) {
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
                return InventoryItemWidget(
                  item: item,
                  onDelete: () {
                    context.read<InventoryBloc>().add(
                      DeleteClothingItemEvent(item.id),
                    );
                  },
                );
              },
            );
          } else if (state is InventoryErrorState) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No items found'));
        },
      ),
    );
  }
}
