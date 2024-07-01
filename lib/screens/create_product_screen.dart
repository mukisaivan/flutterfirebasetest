import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/product_model.dart';
import '../services//firestore_service.dart';

class CreateProductScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  CreateProductScreen({super.key});

  final pid = const Uuid().v1();
  void _createProduct() {
    String id = pid;
    String name = _nameController.text;
    double price = double.parse(_priceController.text);

    _firestoreService.createProduct(Product(id: id, name: name, price: price));
    _idController.clear();
    _nameController.clear();
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'Enter Name'),
        ),
        TextField(
          controller: _priceController,
          decoration: const InputDecoration(hintText: 'Enter Price'),
          keyboardType: TextInputType.number,
        ),
        ElevatedButton(
          onPressed: _createProduct,
          child: const Text('Create Product'),
        ),
      ],
    );
  }
}
