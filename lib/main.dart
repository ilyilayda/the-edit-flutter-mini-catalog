import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';
import 'screens/product_detail_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'The Edit | Mini Catalog',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const CatalogScreen(),
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName &&
              settings.arguments is ProductDetailArguments) {
            return MaterialPageRoute<void>(
                settings: settings,
                builder: (_) => ProductDetailScreen(
                    arguments: settings.arguments! as ProductDetailArguments));
          }
          return null;
        },
      );
}
