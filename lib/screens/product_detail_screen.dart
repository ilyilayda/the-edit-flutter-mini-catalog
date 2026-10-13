import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductDetailArguments {
  final Product product;
  final VoidCallback onAdd;
  const ProductDetailArguments({required this.product, required this.onAdd});
}

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product';
  final ProductDetailArguments arguments;
  const ProductDetailScreen({super.key, required this.arguments});
  @override
  Widget build(BuildContext context) {
    final product = arguments.product;
    return Scaffold(
        appBar: AppBar(title: const Text('Product details')),
        body: Column(children: [
          Expanded(
              child: ListView(children: [
            Image.asset(product.image,
                width: double.infinity, height: 340, fit: BoxFit.cover),
            Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.category.toUpperCase(),
                          style: const TextStyle(
                              color: AppTheme.accent,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2)),
                      const SizedBox(height: 10),
                      Text(product.name,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 10),
                      Row(children: [
                        const Icon(Icons.star_rounded,
                            color: Color(0xFFE3A14A)),
                        Text(' ${product.rating}  •  Curated selection')
                      ]),
                      const SizedBox(height: 20),
                      const Text('Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 19)),
                      const SizedBox(height: 8),
                      Text(
                          '${product.description}. Designed for daily use, '
                          'with thoughtful details and a modern aesthetic.',
                          style: const TextStyle(
                              color: Colors.black54, height: 1.6)),
                    ])),
          ])),
          SafeArea(
              top: false,
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    Expanded(
                        child: Text('₺${product.price}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w900))),
                    Expanded(
                        flex: 2,
                        child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                                backgroundColor: AppTheme.ink,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16)),
                            onPressed: () {
                              arguments.onAdd();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.add_shopping_cart),
                            label: const Text('Add to bag')))
                  ]))),
        ]));
  }
}
