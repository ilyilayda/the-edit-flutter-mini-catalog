import 'package:flutter/material.dart';
import '../data/catalog_repository.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late Future<List<Product>> _productsFuture;
  final Map<int, int> _cart = {};
  String _search = '';
  String _category = 'All';
  int get _cartCount => _cart.values.fold(0, (sum, count) => sum + count);
  @override
  void initState() {
    super.initState();
    _productsFuture = const CatalogRepository().loadProducts();
  }

  void _add(Product product) {
    setState(() => _cart.update(product.id, (quantity) => quantity + 1,
        ifAbsent: () => 1));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${product.name} added to bag'),
        duration: const Duration(seconds: 1)));
  }

  Future<void> _openDetail(Product product) async {
    await Navigator.pushNamed(context, ProductDetailScreen.routeName,
        arguments: ProductDetailArguments(
            product: product, onAdd: () => _add(product)));
  }

  Future<void> _openCart(List<Product> products) async {
    await Navigator.push(
        context,
        MaterialPageRoute<void>(
            builder: (_) => CartScreen(
                products: products,
                quantities: Map.of(_cart),
                onRemove: (id) => setState(() {
                      final count = _cart[id] ?? 0;
                      if (count <= 1) {
                        _cart.remove(id);
                      } else {
                        _cart[id] = count - 1;
                      }
                    }))));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
            child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return Center(
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.error_outline, size: 40),
                      const SizedBox(height: 10),
                      const Text('Unable to load the catalog.'),
                      TextButton(
                          onPressed: () => setState(() {
                                _productsFuture =
                                    const CatalogRepository().loadProducts();
                              }),
                          child: const Text('Try again'))
                    ]));
                  if (!snapshot.hasData)
                    return const Center(child: CircularProgressIndicator());
                  final products = snapshot.data!;
                  final categories = [
                    'All',
                    ...{for (final p in products) p.category}
                  ];
                  final filtered = products
                      .where((p) =>
                          (_category == 'All' || p.category == _category) &&
                          ('${p.name} ${p.category}'
                              .toLowerCase()
                              .contains(_search.toLowerCase())))
                      .toList();
                  return CustomScrollView(slivers: [
                    SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(22, 20, 22, 8),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    const Expanded(
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text('THE EDIT',
                                              style: TextStyle(
                                                  color: AppTheme.accent,
                                                  fontWeight: FontWeight.w900,
                                                  letterSpacing: 3,
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Text('Discover your next favorite.',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 25))
                                        ])),
                                    IconButton(
                                        onPressed: () => _openCart(products),
                                        icon: Badge(
                                            isLabelVisible: _cartCount > 0,
                                            label: Text('$_cartCount'),
                                            child: const Icon(
                                                Icons.shopping_bag_outlined,
                                                size: 27)))
                                  ]),
                                  const SizedBox(height: 24),
                                  Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(22),
                                      decoration: BoxDecoration(
                                          color: AppTheme.ink,
                                          borderRadius:
                                              BorderRadius.circular(22)),
                                      child: const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('CURATED FOR YOU',
                                                style: TextStyle(
                                                    color: Color(0xFFFFB08C),
                                                    letterSpacing: 2,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            SizedBox(height: 8),
                                            Text(
                                                'Everyday essentials,\nbeautifully selected.',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    height: 1.25,
                                                    fontWeight:
                                                        FontWeight.w800)),
                                            SizedBox(height: 10),
                                            Text('Explore the collection below',
                                                style: TextStyle(
                                                    color: Color(0xFFC8C8D2),
                                                    fontSize: 12))
                                          ])),
                                  const SizedBox(height: 22),
                                  TextField(
                                      onChanged: (value) =>
                                          setState(() => _search = value),
                                      decoration: InputDecoration(
                                          hintText: 'Search products...',
                                          prefixIcon: const Icon(Icons.search),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide.none))),
                                  const SizedBox(height: 15),
                                  SizedBox(
                                      height: 43,
                                      child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: categories.length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(width: 8),
                                          itemBuilder: (context, index) {
                                            final category = categories[index];
                                            final selected =
                                                category == _category;
                                            return ChoiceChip(
                                                label: Text(category),
                                                selected: selected,
                                                onSelected: (_) => setState(
                                                    () => _category = category),
                                                selectedColor: AppTheme.accent,
                                                labelStyle: TextStyle(
                                                    color: selected
                                                        ? Colors.white
                                                        : AppTheme.ink,
                                                    fontWeight:
                                                        FontWeight.w700),
                                                side: BorderSide.none,
                                                backgroundColor: Colors.white);
                                          })),
                                  const SizedBox(height: 24),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Explore products',
                                            style: TextStyle(
                                                fontSize: 21,
                                                fontWeight: FontWeight.w800)),
                                        Text('${filtered.length} items',
                                            style: const TextStyle(
                                                color: Colors.grey))
                                      ]),
                                  const SizedBox(height: 15),
                                ]))),
                    if (filtered.isEmpty)
                      const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                              child: Text(
                                  'No products found. Try another search.')))
                    else
                      SliverToBoxAdapter(
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(22, 0, 22, 32),
                              child: LayoutBuilder(
                                  builder: (context, constraints) {
                                final columns =
                                    constraints.maxWidth > 700 ? 4 : 2;
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: filtered.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: columns,
                                            crossAxisSpacing: 13,
                                            mainAxisSpacing: 13,
                                            childAspectRatio: .69),
                                    itemBuilder: (context, index) =>
                                        ProductCard(
                                            product: filtered[index],
                                            onTap: () =>
                                                _openDetail(filtered[index])));
                              }))),
                  ]);
                })),
      );
}
