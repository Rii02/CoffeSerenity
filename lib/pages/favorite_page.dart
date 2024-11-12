import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/widgets/favoriteProvider.dart';
import 'package:coffeeapp/widgets/order_model.dart';
import 'package:coffeeapp/widgets/custombuttontop.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

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
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Favorites", style: TextStyle(color: Colors.white)),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, favoriteProvider, child) {
          if (favoriteProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (favoriteProvider.error != null) {
            return Center(
              child: Text(
                favoriteProvider.error!,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  if (favoriteProvider.favorites.isEmpty)
                    const Center(
                      child: Text(
                        "No favorites yet!",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )
                  else
                    ...favoriteProvider.favorites.map((item) {
                      return _buildFavoriteItem(
                          item, favoriteProvider, context);
                    }).toList(),
                ],
              ),
            ),
          );
        },
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget _buildFavoriteItem(OrderModel item, FavoriteProvider favoriteProvider,
      BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(23),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                item.imagePath,
                width: double.maxFinite,
                height: 300,
                fit: BoxFit.cover,
              ),
              const Positioned(
                top: 30,
                right: 30,
                child: CustomButtonTop(models: Models.icon),
              ),
              _buildItemDetails(item, favoriteProvider, context),
            ],
          ),
          _buildDescription(item.description),
        ],
      ),
    );
  }

  Widget _buildItemDetails(OrderModel item, FavoriteProvider favoriteProvider,
      BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 175,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        item.size,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      favoriteProvider.removeFavorite(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item.name} removed from favorites!'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Container(
      width: double.maxFinite,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.transparent],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Description",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Text(
              description,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
