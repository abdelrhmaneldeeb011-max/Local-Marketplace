// بسم الله الرحمن الرحيم //
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeFirebaseIfSupported();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [Locale('ar'), Locale('en')],
      fallbackLocale: const Locale('ar'),
      child: ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const Wafrnalak(),
      ),
    ),
  );
}

Future<void> _initializeFirebaseIfSupported() async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } on UnsupportedError {
    debugPrint('Firebase is not configured for this platform. Continuing without Firebase init.');
  }
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
      home: const LoginScreen(),
    );
  }
}
