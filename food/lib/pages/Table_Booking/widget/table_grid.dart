import 'package:flutter/material.dart';
import 'table_tile.dart';

class TableGrid extends StatelessWidget {
  final List<bool> tables;
  final Function(int) onTap;

  const TableGrid({super.key, required this.tables, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: tables.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return TableTile(
          index: index,
          isBooked: tables[index],
          onTap: () => onTap(index),
        );
      },
    );
  }
}
