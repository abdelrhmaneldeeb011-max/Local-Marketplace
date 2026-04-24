import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Divider(
                indent: 35,
                endIndent: 10,
                color: Colors.grey,
                thickness: .5,
              ),
            ],
          ),
        ),
        Text('or'.tr()),
        Expanded(
          child: Column(
            children: [
              Divider(
                indent: 10,
                endIndent: 35,
                color: Colors.grey,
                thickness: .5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
