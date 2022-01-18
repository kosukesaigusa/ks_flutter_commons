import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// StreamBuidler の stream プロパティに Firebase Auth の
/// authStateChanges() メソッドを指定して、ユーザーのサインイン状態に
/// もとづいた画面を返すウイジェット。
class AuthStateStreamBuilder extends StatelessWidget {
  const AuthStateStreamBuilder({
    Key? key,
    required this.signedInPage,
    this.waitingWidget = const SizedBox(),
    this.noDataWidget = const SizedBox(),
  }) : super(key: key);

  final Widget signedInPage;
  final Widget waitingWidget;
  final Widget noDataWidget;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }
        if (!snapshot.hasData) {
          return const SizedBox();
        }
        return signedInPage;
      },
    );
  }
}
