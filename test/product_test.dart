import 'package:flutter_test/flutter_test.dart';
import 'package:mini_catalog_project/models/product.dart';

void main() {
  test('Product JSON round-trip preserves values', () {
    const product = Product(
        id: 1,
        name: 'Test',
        category: 'Tech',
        price: 100,
        description: 'Example',
        image: 'assets/images/product_01.png',
        rating: 4.5);
    final restored = Product.fromJson(product.toJson());
    expect(restored.id, 1);
    expect(restored.name, 'Test');
    expect(restored.rating, 4.5);
  });
}
