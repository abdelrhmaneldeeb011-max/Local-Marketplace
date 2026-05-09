import "package:flutter/material.dart";
import 'package:easy_localization/easy_localization.dart';

class Alreadyhaveaccount extends StatelessWidget {
  const Alreadyhaveaccount({
    super.key,
    required this.text1,
    required this.text2,
    required this.fun,
  });

  final String text1;
  final String text2;
  final VoidCallback fun;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1.tr()),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            fun();
          },
          child: Text(
            text2.tr(),
            style: const TextStyle(color: Colors.deepOrange),
          ),
        ),
      ],
    );
  }
}