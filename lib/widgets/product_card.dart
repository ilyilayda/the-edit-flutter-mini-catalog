import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductCard({super.key, required this.product, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(22)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(22)),
                      child: Image.asset(product.image,
                          width: double.infinity, fit: BoxFit.cover))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(12, 11, 12, 13),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.category.toUpperCase(),
                            style: const TextStyle(
                                color: AppTheme.accent,
                                fontSize: 10,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text(product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 14)),
                        const SizedBox(height: 6),
                        Text('₺${product.price}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.ink,
                                fontSize: 15)),
                      ])),
            ])),
      );
}
