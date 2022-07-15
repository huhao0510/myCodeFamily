import 'package:flutter/material.dart';
import 'netWork.dart';
import 'dart:ui';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnectivityStatusExample()
    );
  }
}
