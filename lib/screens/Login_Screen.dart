// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import 'signUp_screen.dart';
import '../widgets/alreadyHaveAccount.dart';
import '../widgets/custom_field.dart';
import '../widgets/loginButton.dart';
import '../widgets/loginWith.dart';
import '../widgets/marketImage.dart';
import '../widgets/orDivider.dart';
import '../widgets/passwordField.dart';
import '../widgets/welcomeMassage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: PopScope(
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            children: [
              WelcomeMessage(
                text1: "welcomeMessage1",
                text2: "welcomeMessage2",
              ),
              Marketimage(),
              SizedBox(height: 20),
              CustomInputField(
                label: 'email'.tr(),
                hint: 'example@mail.com',
                icon: Icons.email,
              ),
              SizedBox(height: 10),
              Passwordfield(
                text: 'password'.tr(),
                forgetPasswordText: 'forgotPassword'.tr(),
                onTap: () {},
              ),
              SizedBox(height: 25),
              Loginbutton(text: Text('login'.tr())),
              SizedBox(height: 20),
              OrDivider(),
              SizedBox(height: 15),
              const Loginwith(),
              Alreadyhaveaccount(
                text1: 'noAccount',
                text2: 'signup',
                fun: () => SignUpScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
