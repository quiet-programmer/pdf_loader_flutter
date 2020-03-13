import 'package:flutter/material.dart';
import 'package:pdf_loader_app/screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PDF Reader",
      home: Home(),
    );
  }
}