import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfirebasetest/models/product_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createProduct(Product product) async {
    await _db.collection('products').doc(product.id).set(product.toMap());
  }

  Future<Product?> readProduct(String id) async {
    var doc = await _db.collection('products').doc(id).get();
    if (doc.exists) {
      return Product.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<void> updateProduct(Product product) async {
    await _db.collection('products').doc(product.id).update(product.toMap());
  }

  Future<void> deleteProduct(String id) async {
    await _db.collection('products').doc(id).delete();
  }

  Stream<List<Product>> readAllProducts() {
    return _db.collection('products').snapshots().map((snapshot) => snapshot
        .docs
        .map((doc) => Product.fromMap(doc.data(), doc.id))
        .toList());
  }
}
