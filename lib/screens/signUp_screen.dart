// بسم الله الرحمن الرحيم //
import '../app_bar.dart';
import 'Login_Screen.dart';
import '../loginAndSignupWidgets/widgets/alreadyHaveAccount.dart';
import '../loginAndSignupWidgets/widgets/custom_field.dart';
import '../loginAndSignupWidgets/widgets/loginWith.dart';
import '../loginAndSignupWidgets/widgets/marketImage.dart';
import '../loginAndSignupWidgets/widgets/orDivider.dart';
import '../loginAndSignupWidgets/widgets/passwordField.dart';
import '../loginAndSignupWidgets/widgets/role.dart';
import '../loginAndSignupWidgets/widgets/welcomeMassage.dart';
import '../providers/auth_provider.dart';
import '../widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  String _role = 'customer';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }
    final auth = context.read<AuthProvider>();
    final success = await auth.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
      _role,
    );
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered successfully! Please login.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const MyAppBar(),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 30),
          children: [
            WelcomeMessage(text1: "signupMassage1", text2: "signupMassage2"),
            Marketimage(),
            SizedBox(height: 20),
            Role(onRoleChanged: (r) => _role = r),
            SizedBox(height: 20),
            CustomInputField(
              controller: _nameController,
              label: 'fullName'.tr(),
              icon: Icons.person,
              hint: 'fullName'.tr(),
            ),
            SizedBox(height: 10),
            CustomInputField(
              controller: _emailController,
              label: 'email'.tr(),
              icon: Icons.email,
              hint: 'email'.tr(),
            ),
            SizedBox(height: 10),
            Passwordfield(
              controller: _passwordController,
              text: 'password',
              forgetPasswordText: '',
            ),
            SizedBox(height: 10),
            Passwordfield(
              controller: _confirmController,
              text: 'confirmPassword',
              forgetPasswordText: '',
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
                textButton: 'signup'.tr(),
                onTap: auth.isLoading ? () {} : _signUp,
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
