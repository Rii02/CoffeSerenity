import 'package:coffeeapp/pages/card_page.dart';
import 'package:coffeeapp/pages/favorite_page.dart';
import 'package:coffeeapp/pages/history_page.dart';
import 'package:coffeeapp/pages/home_page.dart';
import 'package:coffeeapp/widgets/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/widgets/favoriteProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndexBottomNavigationBar = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndexBottomNavigationBar = index;
    });
    _pageController.jumpToPage(index);
    if (index == 2) {
      // Jika index halaman FavoritePage
      _loadUserFavorites(context);
    }
  }

  void _loadUserFavorites(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await Provider.of<FavoriteProvider>(context, listen: false)
          .refreshFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndexBottomNavigationBar = index;
          });
        },
        children: [
          const HomePage(),
          CardPage(),
          const FavoritePage(),
          const HistoryPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndexBottomNavigationBar,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
