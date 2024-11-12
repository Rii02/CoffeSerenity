import 'package:flutter/material.dart';
import 'order_model.dart';

class CartProvider with ChangeNotifier {
  final List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  void addOrder(OrderModel order) {
    _orders.add(order);
    notifyListeners(); // Notify the listeners (e.g., UI) about the update
  }

  void removeOrder(OrderModel order) {
    _orders.remove(order);
    notifyListeners();
  }

  double get totalPrice {
    return _orders.fold(
        0.0, (sum, order) => sum + (order.price * order.quantity));
  }

  void clearCart() {
    _orders.clear(); // Clear the list of orders
    notifyListeners(); // Notify listeners that the cart has been cleared
  }
}
