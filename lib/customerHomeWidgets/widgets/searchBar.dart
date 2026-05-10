import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  final ValueChanged<String>? onSearch;
  const MySearchBar({super.key, this.onSearch});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    widget.onSearch?.call(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
        child: SearchBar(
          controller: _controller,
          onSubmitted: (_) => _submit(),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          shadowColor: WidgetStateProperty.all(Colors.grey[50]),
          hintText: 'Search'.tr(),
          hintStyle: const WidgetStatePropertyAll(
            TextStyle(color: Colors.grey),
          ),
          leading: const Icon(Icons.search, color: Colors.grey),
          trailing: [
            IconButton(
              icon: Icon(Icons.arrow_forward, color: Colors.grey),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
