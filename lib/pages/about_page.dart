import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.black),
        child: Stack(
          children: [
            // Background Color with Rounded Bottom Corners
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 793,
                decoration: const ShapeDecoration(
                  color: Color(0xFFB27C2A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ),
            // "Welcome !!" Text
            Positioned(
              left: (MediaQuery.of(context).size.width - 224) / 2,
              top: 31,
              child: const SizedBox(
                width: 224,
                height: 40,
                child: Text(
                  'Welcome !!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3.60,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Logo di bawah teks "Welcome !!"
            Positioned(
              left: (MediaQuery.of(context).size.width - 400) / 2,
              top: -20,
              child: Image.asset(
                'assets/images/logo1.png', // Path dari logo yang diupload
                width: 400,
                height: 400,
              ),
            ),
            // White Rounded Container for Details
            Positioned(
              left: 18,
              top: 300,
              child: Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 463,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),
            // "Pendidikan Teknologi Informasi" Text
            Positioned(
              left: 32,
              top: 317,
              child: const SizedBox(
                width: 340,
                height: 30,
                child: Text(
                  'Pendidikan Teknologi Informasi',
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
            // "Dibuat Oleh:" Text
            Positioned(
              left: 37,
              top: 371,
              child: const SizedBox(
                width: 340,
                height: 96,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dibuat Oleh:\n',
                        style: TextStyle(
                          color: Color(0xFF674624),
                          fontSize: 17,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                      TextSpan(
                        text:
                            'Nadiva Olivia Subana\nFakhrudin Rifki Amri\nLenny Yuwita',
                        style: TextStyle(
                          color: Color(0xFF674624),
                          fontSize: 14,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // "NIM:" Text
            Positioned(
              left: 37,
              top: 465,
              child: const SizedBox(
                width: 340,
                height: 96,
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'NIM:\n',
                        style: TextStyle(
                          color: Color(0xFF674624),
                          fontSize: 17,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                      TextSpan(
                        text: '23050974001\n23050974025\n23050974028',
                        style: TextStyle(
                          color: Color(0xFF674624),
                          fontSize: 14,
                          fontFamily: 'Cabin',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Description Text di tengah
            Positioned(
              left: 12,
              top: 580,
              child: const SizedBox(
                width: 374,
                child: Text(
                  'Serenity Coffee adalah aplikasi yang dirancang untuk \nmemudahkan pelanggan dalam memesan kopi \nsecara praktis melalui Handphone mereka.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF674624),
                    fontSize: 11,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.60,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 630,
              child: const SizedBox(
                width: 374,
                child: Text(
                  'Aplikasi ini menawarkan berbagai fitur yang intuitif \ndan interaktif, mulai dari pemilihan menu \nhingga manajemen transaksi.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF674624),
                    fontSize: 11,
                    fontFamily: 'Cabin',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.60,
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
