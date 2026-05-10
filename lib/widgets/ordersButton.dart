import 'package:flutter/material.dart';

class OrdersButton extends StatelessWidget {
  const OrdersButton({super.key, required this.text, this.onTap, this.selected = false});
  final String text;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          constraints: const BoxConstraints(minHeight: 28),
          color: selected ? Colors.deepOrange[600] : Colors.deepOrange[400],
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Center(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
    );
  }
}
