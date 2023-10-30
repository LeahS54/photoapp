import 'package:flutter/material.dart';
import 'package:flutter_photo/images_app_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.purpleAccent),
      home: const MultipleImageSelector(),
      debugShowCheckedModeBanner: false,
    );
  }
}
