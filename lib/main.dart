import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram App',
      theme: ThemeData.dark(),
      home: MyHomePage(title: 'Wasteagram'),
    );
  }
}
