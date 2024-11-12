class OrderModel {
  final String imagePath;
  final String name;
  final String size;
  final String description;
  final double price;
  final int quantity;

  OrderModel({
    required this.imagePath,
    required this.name,
    required this.size,
    required this.description,
    required this.price,
    this.quantity = 1,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          size == other.size;

  @override
  int get hashCode => name.hashCode ^ size.hashCode;
  // Convert OrderModel to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'imagePath': imagePath,
      'name': name,
      'size': size,
      'description': description,
      'price': price,
      'quantity': quantity,
    };
  }

  // Create OrderModel from Firestore data
  static OrderModel fromFirestore(Map<String, dynamic> data) {
    return OrderModel(
      imagePath: data['imagePath'],
      name: data['name'],
      size: data['size'],
      description: data['description'],
      price: data['price'],
      quantity: data['quantity'] ?? 1,
    );
  }
}
