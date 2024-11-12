import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/widgets/card_provider.dart';
import 'payment_page.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            const Text("Keranjang Anda", style: TextStyle(color: Colors.white)),
      ),
      body: cart.orders.isEmpty
          ? const Center(
              child: Text("Keranjang Anda kosong.",
                  style: TextStyle(color: Colors.white)))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.orders.length,
                    itemBuilder: (context, index) {
                      final order = cart.orders[index];
                      return ListTile(
                        leading:
                            Image.asset(order.imagePath, width: 60, height: 60),
                        title: Text(order.name,
                            style: const TextStyle(color: Colors.white)),
                        subtitle: Text(
                            "Ukuran: ${order.size}, Jumlah: ${order.quantity}",
                            style: const TextStyle(color: Colors.white)),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                "Rp.${(order.price * order.quantity).toStringAsFixed(3)}",
                                style: const TextStyle(color: Colors.white)),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                // Menghapus pesanan yang dipilih dari keranjang
                                cart.removeOrder(
                                    order); // Hanya item ini yang dihapus
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: Rp.${cart.totalPrice.toStringAsFixed(3)}",
                          style: const TextStyle(color: Colors.white)),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentPage(),
                          ));
                        },
                        child: const Text("Bayar"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
