import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_todo_app/Sign_In/SignInPage.dart';
import 'package:flutter/material.dart';

// 준비작업
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// 로그인 페이지로 이동
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
