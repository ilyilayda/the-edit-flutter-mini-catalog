import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product.dart';

class CatalogRepository {
  const CatalogRepository();
  Future<List<Product>> loadProducts() async {
    final raw = await rootBundle.loadString('assets/data/products.json');
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
