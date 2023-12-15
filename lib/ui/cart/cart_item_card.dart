import 'package:flutter/material.dart';
import 'package:myproject_app/ui/cart/cart_manager.dart';
import 'package:provider/provider.dart';

import '../../models/cart_item.dart';
import '../../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cartItem;

  const CartItemCard({
    required this.productId,
    required this.cartItem,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) {
        return showConfirmDialog(
          context,
          'Bạn muốn xóa sản phẩm?',
        );
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: ClipOval(child: Image.network(cartItem.imageUrl),),
          title: Text(cartItem.name),
          subtitle: Text('Tổng: \$${cartItem.price * cartItem.quantity}'),
          trailing: Text('x ${cartItem.quantity}'),
        ),
      ),
    );
  }
}
