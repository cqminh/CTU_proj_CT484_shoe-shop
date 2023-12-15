class CartItem {
  final String id;
  final String name;
  final String imageUrl;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
