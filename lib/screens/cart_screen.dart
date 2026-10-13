import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatefulWidget {
  final List<Product> products;
  final Map<int, int> quantities;
  final ValueChanged<int> onRemove;
  const CartScreen(
      {super.key,
      required this.products,
      required this.quantities,
      required this.onRemove});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final selected = widget.products
        .where((p) => (widget.quantities[p.id] ?? 0) > 0)
        .toList();
    final total = selected.fold<int>(0,
        (sum, product) => sum + product.price * widget.quantities[product.id]!);
    return Scaffold(
        appBar: AppBar(title: const Text('Your bag')),
        body: selected.isEmpty
            ? const Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.shopping_bag_outlined, size: 72, color: Colors.grey),
                SizedBox(height: 18),
                Text('Your bag is empty',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Discover something you love!')
              ]))
            : Column(children: [
                Expanded(
                    child: ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemCount: selected.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final product = selected[index];
                          return Card(
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.asset(product.image,
                                            width: 82,
                                            height: 82,
                                            fit: BoxFit.cover)),
                                    const SizedBox(width: 14),
                                    Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text(product.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w800)),
                                          const SizedBox(height: 6),
                                          Text(
                                              '₺${product.price}  ×  ${widget.quantities[product.id]}'),
                                        ])),
                                    IconButton(
                                        tooltip: 'Remove one',
                                        onPressed: () {
                                          widget.onRemove(product.id);
                                          setState(() {
                                            final count =
                                                widget.quantities[product.id]! -
                                                    1;
                                            if (count <= 0) {
                                              widget.quantities
                                                  .remove(product.id);
                                            } else {
                                              widget.quantities[product.id] =
                                                  count;
                                            }
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.remove_circle_outline)),
                                  ])));
                        })),
                Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Subtotal',
                                style: TextStyle(fontSize: 18)),
                            Text('₺$total',
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.w900))
                          ]),
                      const SizedBox(height: 14),
                      const Text('Demo only • No real purchases or payments',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                      const SizedBox(height: 10),
                      SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                              onPressed: () => showDialog<void>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                          title: const Text('Demo checkout'),
                                          content: const Text(
                                              'Checkout is a simulation. No order was placed.'),
                                          actions: [
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('OK'))
                                          ])),
                              style: FilledButton.styleFrom(
                                  backgroundColor: AppTheme.ink,
                                  padding: const EdgeInsets.all(16)),
                              child: const Text('Checkout'))),
                    ]))
              ]));
  }
}
