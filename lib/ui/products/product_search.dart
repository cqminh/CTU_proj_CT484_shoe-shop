import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'product_info.dart';
import 'products_manager.dart';

class ProductSearch extends StatelessWidget {
  static const routeName = '/search-product';

  const ProductSearch(
      this.value,
      {super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    final result = ProductsManager().findByName(value);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kết quả cho: $value',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: result.length,
          itemBuilder: (ctx, i) => ProductInfo(result[i]),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
    );
  }
}
