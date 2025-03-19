import 'package:flutter/material.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';

class InventoryItemWidget extends StatelessWidget {
  final ClothingItemEntity item;
  final VoidCallback onDelete;

  const InventoryItemWidget({
    super.key,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(child: Image.network(item.imageUrl, fit: BoxFit.cover)),
          Padding(padding: const EdgeInsets.all(8.0), child: Text(item.name)),
          IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
        ],
      ),
    );
  }
}
