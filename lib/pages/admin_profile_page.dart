import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginPage.dart'; // Pastikan untuk mengimpor halaman login

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            // Background shape
            Positioned(
              left: 0,
              top: 318,
              child: Container(
                width: 390,
                height: 545,
                decoration: ShapeDecoration(
                  color: const Color(0xFFB27C2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
            // Profile image at the top
            Positioned(
              top: -60,
              left: (MediaQuery.of(context).size.width - 450) / 2,
              child: Image.asset(
                'assets/images/logo1.png',
                width: 450,
                height: 450,
              ),
            ),
            // Circle avatar inside orange box
            Positioned(
              top: 350,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            // Email label and box
            Positioned(
              left: 53,
              top: 480,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      user?.email ?? "No email",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Username label and box
            Positioned(
              left: 53,
              top: 570,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Username:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                        if (snapshot.hasError) {
                          return const Text(
                            'Error fetching username',
                            style: TextStyle(color: Colors.black),
                          );
                        }
                        if (snapshot.hasData && snapshot.data != null) {
                          final data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Text(
                            data['username'] ?? "No username",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          );
                        }
                        return const Text(
                          'No username found',
                          style: TextStyle(color: Colors.black),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Sign Out Button
            Positioned(
              left: 84,
              top: 700,
              child: GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
                child: Container(
                  width: 224,
                  height: 64,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F4F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'SIGN OUT',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Cabin',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
