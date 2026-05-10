import '../../widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Categorylist extends StatefulWidget {
  const Categorylist({super.key, this.onCategorySelected});
  final ValueChanged<int?>? onCategorySelected;

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'Grocery', 'icon': Icons.shopping_basket},
    {'id': 2, 'name': 'Bakery', 'icon': Icons.bakery_dining},
    {'id': 3, 'name': 'Electronics', 'icon': Icons.devices},
    {'id': 4, 'name': 'Fashion', 'icon': Icons.dry_cleaning},
    {'id': 5, 'name': 'Health', 'icon': Icons.local_hospital},
  ];

  int? _selectedId;

  void _select(int? id) {
    setState(() => _selectedId = id);
    widget.onCategorySelected?.call(id);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: _selectedId == null ? Colors.deepOrange : Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => _select(null),
            child: Text(
              'All'.tr(),
              style: TextStyle(
                color: _selectedId == null ? Colors.white : Colors.deepOrange,
              ),
            ),
          ),
          const SizedBox(width: 15),
          ..._categories.map((c) {
            final selected = _selectedId == c['id'];
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Button(
                icon: Icon(c['icon']),
                textButton: c['name'].tr(),
                onTap: () => _select(c['id']),
                iconSize: 18,
                iconColor: selected ? Colors.white : Colors.deepOrange,
                backgroundColor: selected ? Colors.deepOrange : Colors.grey[300]!,
                textcolor: selected ? Colors.white : Colors.deepOrange,
                textsize: 12,
                shadowcolor: Colors.transparent,
              ),
            );
          }),
        ],
      ),
    );
  }
}
