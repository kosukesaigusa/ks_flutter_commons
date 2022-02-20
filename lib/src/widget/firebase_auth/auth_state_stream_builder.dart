import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// StreamBuilder の stream プロパティに Firebase Auth の
/// authStateChanges() メソッドを指定して、ユーザーのサインイン状態に
/// もとづいた画面を返すウイジェット。
class AuthStateStreamBuilder extends StatelessWidget {
  const AuthStateStreamBuilder({
    Key? key,
    required this.builder,
    this.waitingWidget = const SizedBox(),
    this.notSignedInWidget = const SizedBox(),
  }) : super(key: key);

  final Widget Function(BuildContext context) builder;
  final Widget waitingWidget;
  final Widget notSignedInWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return waitingWidget;
        }
        if (!snapshot.hasData) {
          return notSignedInWidget;
        }
        return builder(context);
      },
    );
  }
}
