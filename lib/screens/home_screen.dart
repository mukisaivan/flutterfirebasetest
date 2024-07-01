import 'package:flutter/material.dart';
import 'package:flutterfirebasetest/screens/create_product_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CreateProductScreen(),
          ],
        ),
      ),
    );
  }
}
