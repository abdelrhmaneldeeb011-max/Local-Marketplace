// بسم الله الرحمن الرحيم //
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// ✅ Custom Exception عشان نعرف إيه المشكلة بالظبط
class AuthException implements Exception {
  final String message;
  final String code;
  AuthException({required this.message, required this.code});
}

class AuthService {
  AuthService() : _auth = _resolveAuth();

  final FirebaseAuth? _auth;

  static FirebaseAuth? _resolveAuth() {
    try {
      return FirebaseAuth.instance;
    } on FirebaseException {
      return null;
    }
  }

  FirebaseAuth get _requireAuth {
    final auth = _auth;
    if (auth == null) {
      throw AuthException(
        code: 'firebase-not-configured',
        message: 'Firebase Auth is not configured for this platform.',
      );
    }
    return auth;
  }

  // ✅ Stream للـ UI يستمع لحالة المستخدم
  Stream<User?> get authStateChanges => _requireAuth.authStateChanges();

  // ✅ التحقق من قوة الباسورد
  bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // ✅ تسجيل الدخول مع Error Messages واضحة
  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _requireAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = userCredential.user;

      if (user != null) {
        if (user.emailVerified) {
          debugPrint("✅ User Logged In: ${user.email}");
          return user;
        } else {
          // ✅ بنعمل sign out عشان ميفضلش logged in من غير تأكيد
          await _requireAuth.signOut();
          throw AuthException(
            code: 'email-not-verified',
            message: 'من فضلك فعّل إيميلك الأول.\nتحقق من inbox بتاعك.',
          );
        }
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: _getArabicErrorMessage(e.code),
      );
    }
  }

  // ✅ تسجيل مستخدم جديد مع الاسم + Email Verification
  Future<User?> register(String email, String password, String name) async {
    // ✅ التحقق من قوة الباسورد قبل ما نبعت للـ Firebase
    if (!isPasswordStrong(password)) {
      throw AuthException(
        code: 'weak-password',
        message:
            'الباسورد لازم يكون:\n• 8 حروف على الأقل\n• حرف كبير\n• رقم\n• رمز خاص مثل (!@#)',
      );
    }

    try {
      UserCredential userCredential = await _requireAuth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );
      User? user = userCredential.user;

      if (user != null) {
        // ✅ حفظ الاسم في Firebase
        await user.updateDisplayName(name.trim());
        debugPrint("✅ User Registered: ${user.email}");

        // ✅ إرسال إيميل تأكيد
        await user.sendEmailVerification();
        debugPrint("📧 Verification email sent to: ${user.email}");

        // ✅ Sign out بعد التسجيل عشان يفعّل الإيميل الأول
        await _requireAuth.signOut();
      }
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: _getArabicErrorMessage(e.code),
      );
    }
  }

  // ✅ إعادة إرسال إيميل التفعيل
  Future<void> resendVerificationEmail() async {
    User? user = _requireAuth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      debugPrint("📧 Verification email re-sent to: ${user.email}");
    } else {
      throw AuthException(
        code: 'no-user',
        message: 'مفيش مستخدم logged in حالياً.',
      );
    }
  }

  // ✅ إعادة تعيين كلمة المرور
  Future<void> resetPassword(String email) async {
    try {
      await _requireAuth.sendPasswordResetEmail(email: email.trim());
      debugPrint("📧 Password reset email sent to: $email");
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: _getArabicErrorMessage(e.code),
      );
    }
  }

  // ✅ التحقق لو الإيميل اتفعّل
  Future<bool> checkEmailVerified() async {
    await _requireAuth.currentUser?.reload();
    return _requireAuth.currentUser?.emailVerified ?? false;
  }

  // ✅ تسجيل الخروج
  Future<void> logout() async {
    await _requireAuth.signOut();
    debugPrint("✅ User Logged Out");
  }

  // ✅ المستخدم الحالي
  User? get currentUser => _requireAuth.currentUser;

  // ✅ ترجمة Firebase error codes لرسائل عربية
  String _getArabicErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'email-already-in-use':
        return 'An account with this email already exists. Try logging in instead.';
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'too-many-requests':
        return 'Too many failed attempts. Please wait a moment and try again..';
      case 'network-request-failed':
        return 'Connection failed. Please check your internet and try again.';
      case 'user-disabled':
        return 'Your account has been suspended. Please contact support for help';
      case 'invalid-credential':
        return 'The email or password you entered is incorrect. Please try again';
      default:
        return 'Something went wrong. Please try again late';
    }
  }
}
