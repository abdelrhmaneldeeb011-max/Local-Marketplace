// بسم الله الرحمن الرحيم //
import 'package:wafrnalak/loginAndSignupWidgets/widgets/custom_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Passwordfield extends StatefulWidget {
  const Passwordfield({
    super.key,
    required this.text,
    this.forgetPasswordText,
    this.onTap,
    this.controller,
  });

  final String text;
  final String? forgetPasswordText;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  @override
  State<Passwordfield> createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final showForgot =
        widget.forgetPasswordText != null &&
        widget.forgetPasswordText!.isNotEmpty;

    return CustomInputField(
      label: widget.text.tr(),
      icon: Icons.lock,
      hint: '********',
      isPassword: _obscure,
      controller: widget.controller,
      suffixIcon: IconButton(
        icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
      trailing: showForgot
          ? TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: widget.onTap,
              child: Text(
                widget.forgetPasswordText!.tr(),
                style: const TextStyle(color: Colors.deepOrange),
              ),
            )
          : null,
    );
  }
}