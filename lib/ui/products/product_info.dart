import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myproject_app/ui/products/product_detail_screen.dart';
import '../../models/product.dart';

class ProductInfo extends StatelessWidget {
  const ProductInfo(
    this.product, {
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: buildGridFooterBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => ProductDetailScreen(product)),
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              
            ),
          ),
        ],
      ),
    );
  }
}
