import 'package:flutter/material.dart';
import 'view/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Club Obesidad',
      theme: ThemeData(primarySwatch: Colors.indigo, useMaterial3: true),
      home: const HomeView(),
    );
  }
}
