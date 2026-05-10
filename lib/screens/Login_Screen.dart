// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import 'customer_home_screen.dart';
import 'signUp_screen.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';
import '../providers/auth_provider.dart';
import '../widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (success && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CustomerHomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBar(),
      body: PopScope(
        child: SizedBox(
          width: double.infinity,
          child: ListView(
            padding: const EdgeInsets.only(top: 30),
            children: [
              WelcomeMessage(
                text1: "welcomeMessage1",
                text2: "welcomeMessage2",
              ),
              Marketimage(),
              SizedBox(height: 20),
              CustomInputField(
                controller: _emailController,
                label: 'email'.tr(),
                hint: 'example@mail.com',
                icon: Icons.email,
              ),
              SizedBox(height: 10),
              Passwordfield(
                controller: _passwordController,
                text: 'password',
                forgetPasswordText: 'forgotPassword',
                onTap: () {},
              ),
              if (auth.error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                  child: Text(
                    auth.error!,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
              SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Button(
                  icon: Icon(Icons.arrow_forward),
                  textButton: 'login'.tr(),
                  onTap: auth.isLoading ? () {} : _login,
                  iconSize: 20,
                  iconColor: Colors.white70,
                  backgroundColor: auth.isLoading ? Colors.grey : Colors.deepOrange,
                  textcolor: Colors.white,
                  textsize: 14,
                  shadowcolor: Colors.grey,
                ),
              ),
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
