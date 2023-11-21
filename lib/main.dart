import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'view/page/Home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vi-Wall',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: const HomePage(),
    );
  }
}
