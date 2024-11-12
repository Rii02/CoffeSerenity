import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  // Mendapatkan riwayat pesanan dari Firestore
  Stream<QuerySnapshot> getOrderHistory() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('history')
          .orderBy('orderDate', descending: true)
          .snapshots();
    }
    return const Stream.empty();
  }

  // Fungsi untuk menghapus riwayat pesanan
  Future<void> deleteOrder(String orderId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('history')
          .doc(orderId)
          .delete();
    }
  }

  // Format the date to a readable string
  String formatDate(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Riwayat Pesanan",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: getOrderHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Gagal memuat riwayat pesanan"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Tidak ada riwayat pesanan."));
          }

          final orderHistory = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: orderHistory.length,
            itemBuilder: (context, index) {
              final orderDoc = orderHistory[index];
              final orderData = orderDoc.data() as Map<String, dynamic>;
              final orderDate = (orderData['orderDate'] as Timestamp);
              final totalAmount = orderData['totalAmount'];
              final items = orderData['items'] as List<dynamic>;
              final username =
                  orderData['username'] ?? 'Nama Pengguna Tidak Ditemukan';

              return Card(
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pembeli: $username",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Tanggal: ${formatDate(orderDate)}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...items.map((item) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                "${item['name']} - Ukuran: ${item['size']}, Jumlah: ${item['quantity']}, Harga: Rp.${(item['price'] * item['quantity']).toStringAsFixed(3)}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            )),
                        const Divider(color: Colors.black),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            "Total: Rp.${totalAmount.toStringAsFixed(3)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(255, 216, 130, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Konfirmasi penghapusan
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Hapus Riwayat"),
                              content: const Text(
                                  "Apakah Anda yakin ingin menghapus riwayat ini?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text("Hapus"),
                                ),
                              ],
                            );
                          },
                        );

                        if (shouldDelete == true) {
                          await deleteOrder(orderDoc.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Riwayat pesanan berhasil dihapus.")),
                          );
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }
}
