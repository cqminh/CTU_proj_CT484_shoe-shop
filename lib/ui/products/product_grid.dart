import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'product_info.dart';
import 'products_manager.dart';



class ProductGrid extends StatefulWidget {
  const ProductGrid(
    // this.product, 
    {super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  // final Product product;
  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Consumer<ProductsManager>(
      builder: (context,  productsManager, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => ProductInfo(productsManager.items[i]),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      }
    );
  }
}
