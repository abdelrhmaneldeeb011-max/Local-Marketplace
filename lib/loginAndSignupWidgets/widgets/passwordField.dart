import 'package:Wafrnalak/loginAndSignupWidgets/widgets/custom_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Passwordfield extends StatefulWidget {
  Passwordfield({
    super.key,
    required this.text,
    this.forgetPasswordText,
    this.onTap,
  });
  final String text;
  final String? forgetPasswordText;
  final VoidCallback? onTap;

  @override
  State<Passwordfield> createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  bool O = true;

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return CustomInputField(
      label: widget.text.tr(),
      icon: Icons.lock,
      hint: '********',
      isPassword: O,
      suffixIcon: IconButton(
        icon: Icon(O ? Icons.visibility : Icons.visibility_off),
        onPressed: () => setState(() => O = !O),
      ),
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
          minimumSize: Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: widget.onTap,
        child: Text(
          widget.forgetPasswordText!.tr(),
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
    );
  }
}
