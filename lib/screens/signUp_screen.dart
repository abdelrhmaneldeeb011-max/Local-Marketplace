// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import 'Login_Screen.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginButton.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/role.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: ListView(
          children: [
            WelcomeMessage(text1: "signupMassage1", text2: "signupMassage2"),
            Marketimage(),
            SizedBox(height: 20),
            const Role(),
            SizedBox(height: 20),
            CustomInputField(
              label: 'fullName'.tr(),
              icon: Icons.person,
              hint: 'fullName'.tr(),
            ),
            SizedBox(height: 10),
            CustomInputField(
              label: 'email'.tr(),
              icon: Icons.email,
              hint: 'email'.tr(),
            ),
            SizedBox(height: 10),
            Passwordfield(text: 'password', forgetPasswordText: ''),
            SizedBox(height: 10),
            Passwordfield(text: 'confirmPassword', forgetPasswordText: ''),
            SizedBox(height: 25),
            Loginbutton(text: Text('signup'.tr())),
            SizedBox(height: 20),
            OrDivider(),
            SizedBox(height: 15),
            const Loginwith(),
            Alreadyhaveaccount(
              text1: 'alreadyHaveAccount',
              text2: 'login',
              fun: () => LoginScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
