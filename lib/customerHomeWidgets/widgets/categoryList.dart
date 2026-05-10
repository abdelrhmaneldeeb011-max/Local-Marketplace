import '../../models/category.dart';
import '../../services/api_service.dart';
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
  List<Category> _categories = [];
  int? _selectedId;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final cats = await ApiService.getCategories();
      if (mounted) {
        setState(() {
          _categories = cats;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _select(int? id) {
    setState(() => _selectedId = id);
    widget.onCategorySelected?.call(id);
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const SizedBox(
        height: 40,
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
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
            child: Text('All'.tr(), style: TextStyle(color: _selectedId == null ? Colors.white : Colors.deepOrange)),
          ),
          const SizedBox(width: 15),
          ..._categories.map((c) {
            final selected = _selectedId == c.id;
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Button(
                icon: const Icon(Icons.category),
                textButton: c.name,
                onTap: () => _select(c.id),
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
