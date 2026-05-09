import 'package:wafrnalak/customerHomeWidgets/widgets/shopsCard.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Shopsview extends StatefulWidget {
  const Shopsview({super.key});

  @override
  State<Shopsview> createState() => _ShopsviewState();
}

class _ShopsviewState extends State<Shopsview> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Local Shops Near You'.tr(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All'.tr(),
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          ShopsCard(),
          ShopsCard(),
        ],
      ),
    );
  }
}
