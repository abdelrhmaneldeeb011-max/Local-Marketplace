                    // بسم الله الرحمن الرحيم //
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final Widget? suffixIcon;
  final Widget? trailing; // <--- الزرار اللي فوق الـ TextField

  const CustomInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.suffixIcon,
    this.trailing, // اختياري
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر اللي فيه العنوان وزرار "نسيت كلمة المرور"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              if (trailing != null) trailing!, // لو بعت زرار هيظهره هنا
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            autofocus: false,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              prefixIcon: Icon(icon),
              prefixIconColor: const Color.fromARGB(255, 157, 157, 157),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
