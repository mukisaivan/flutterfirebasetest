import 'package:flutter/material.dart';

class ItemsScreen extends StatefulWidget {
  static const routeName = "/items-screen";
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Itn'),
      ),
    );
  }
}
