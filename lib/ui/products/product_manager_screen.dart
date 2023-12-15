import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:myproject_app/ui/products/edit_product_screen.dart';
import 'package:provider/provider.dart';

import 'product_list_manager.dart';
import 'products_manager.dart';

class ProductManagerScreen extends StatelessWidget {
  static const routeName = '/manager-product';

  const ProductManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quản lý sản phẩm'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => print('refresh products'),
        child: buildProductList(productsManager),
      ),
    );
  }

  Widget buildProductList(ProductsManager productsManager) {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
             ProductListManager(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(EditProductScreen.routeName);
      },
    );
  }
}
