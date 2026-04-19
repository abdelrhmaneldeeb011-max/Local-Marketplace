import "package:flutter/material.dart";
import 'package:easy_localization/easy_localization.dart';

class Alreadyhaveaccount extends StatefulWidget {
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
  State<Alreadyhaveaccount> createState() => _AlreadyhaveaccountState();
}

class _AlreadyhaveaccountState extends State<Alreadyhaveaccount> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(widget.text1.tr()),
        TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.fun() as Widget),
            );
          },
          child: Text(
            widget.text2.tr(),
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
      ],
    );
  }
}
