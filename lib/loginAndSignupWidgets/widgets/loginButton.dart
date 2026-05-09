import '../../screens/customer_home_screen.dart';
import '../../widgets/button.dart';
import 'package:flutter/material.dart';

class Loginbutton extends StatefulWidget {
  const Loginbutton({super.key, required this.text});
  final Text text ;

  @override
  State<Loginbutton> createState() => _LoginbuttonState();
}

class _LoginbuttonState extends State<Loginbutton> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Button(
        icon: Icon(Icons.arrow_forward),
        textButton: widget.text.data!,
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomerHomeScreen()),
          );
        },
        iconSize: 20,
        iconColor: Colors.white70,
        backgroundColor: Colors.deepOrange,
        textcolor: Colors.white,
        textsize: 14,
        shadowcolor: Colors.grey,
      ),
    );
  }
}
