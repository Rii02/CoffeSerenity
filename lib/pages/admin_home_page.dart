import 'package:flutter/material.dart';
import 'admin_order_page.dart';
import 'admin_profile_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            clipBehavior: Clip.antiAlias,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight - 136,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFB27C2A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  child: Image.asset(
                    'assets/images/logo1.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome !!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3.60,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Select one of the menus you want to use',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfilePage()),
                          );
                        },
                        child: Container(
                          width: 332,
                          height: 64,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Profil Admin',
                              style: TextStyle(
                                color: Color(0xFF674624),
                                fontSize: 20,
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminOrderPage()),
                          );
                        },
                        child: Container(
                          width: 332,
                          height: 64,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Lihat Semua Pesanan',
                              style: TextStyle(
                                color: Color(0xFF674624),
                                fontSize: 20,
                                fontFamily: 'Cabin',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
