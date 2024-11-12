import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffeeapp/widgets/card_provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  Future<String> fetchUsername(String userId) async {
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc.data()?['username'] ?? 'Unknown User';
  }

  Future<void> saveOrderToHistory(BuildContext context) async {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userId = user.uid;
      final username = await fetchUsername(userId);

      final historyCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('history');
      final adminOrdersCollection =
          FirebaseFirestore.instance.collection('admin_orders');

      // Gunakan WriteBatch untuk menulis ke beberapa dokumen sekaligus
      final batch = FirebaseFirestore.instance.batch();

      // Buat dokumen pesanan baru di koleksi history pengguna
      final newOrderDoc = historyCollection.doc();
      batch.set(newOrderDoc, {
        'orderDate': FieldValue.serverTimestamp(),
        'totalAmount': cart.totalPrice,
        'items': cart.orders
            .map((order) => {
                  'name': order.name,
                  'size': order.size, // Tambahkan size di sini
                  'quantity': order.quantity,
                  'price': order.price,
                })
            .toList(),
        'username': username,
      });

      // Buat dokumen pesanan baru di koleksi admin_orders
      final newAdminOrderDoc = adminOrdersCollection.doc();
      batch.set(newAdminOrderDoc, {
        'userId': userId,
        'username': username,
        'orderDate': FieldValue.serverTimestamp(),
        'totalAmount': cart.totalPrice,
        'items': cart.orders
            .map((order) => {
                  'name': order.name,
                  'size': order.size, // Tambahkan size di sini
                  'quantity': order.quantity,
                  'price': order.price,
                })
            .toList(),
      });

      // Menjalankan batch
      await batch.commit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Pembayaran", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              "Tagihan Anda",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: cart.orders.length,
                itemBuilder: (context, index) {
                  final order = cart.orders[index];
                  return ListTile(
                    title: Text(order.name,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                      "Ukuran: ${order.size}, Jumlah: ${order.quantity}, Harga: Rp.${(order.price * order.quantity).toStringAsFixed(3)}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            Text(
              "Total: Rp.${cart.totalPrice.toStringAsFixed(3)}",
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  await saveOrderToHistory(context);

                  // Kosongkan keranjang setelah transaksi berhasil
                  cart.clearCart();

                  // Tampilkan pesan berhasil
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Pembayaran berhasil! Pesanan disimpan ke riwayat dan admin."),
                    ),
                  );

                  // Kembali ke halaman sebelumnya (CardPage)
                  Navigator.of(context).pop();
                } catch (e) {
                  // Tampilkan pesan error jika penyimpanan gagal
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Gagal menyimpan pesanan. Silakan coba lagi."),
                    ),
                  );
                }
              },
              child: const Text("Konfirmasi Pembayaran"),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
