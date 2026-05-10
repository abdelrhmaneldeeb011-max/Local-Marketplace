// بسم الله الرحمن الرحيم //
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar'), Locale('en')],
      fallbackLocale: const Locale('en'),
      child: ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const Wafrnalak(),
      ),
    ),
  );
}

class Wafrnalak extends StatelessWidget {
  const Wafrnalak({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: LoginScreen(),
    );
  }
}
