import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoriteProvider with ChangeNotifier {
  List<OrderModel> _favorites = [];
  bool _isLoading = true;
  String? _error;

  List<OrderModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FavoriteProvider() {
    _loadFavorites();
  }

  // Load favorites from Firestore
  Future<void> _loadFavorites() async {
    try {
      _isLoading = true;
      notifyListeners();

      final user = _auth.currentUser;
      if (user != null) {
        final snapshot = await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .get();

        _favorites = snapshot.docs
            .map((doc) => OrderModel.fromFirestore(doc.data()))
            .toList();
      } else {
        _favorites = [];
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Gagal memuat favorit: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add favorite to Firestore
  Future<void> addFavorite(OrderModel item) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(item.name) // Menggunakan nama sebagai ID dokumen
            .set(item.toFirestore());

        _favorites.add(item);
        notifyListeners();
        await refreshFavorites();
      }
    } catch (e) {
      _error = 'Gagal menambah favorit: $e';
      notifyListeners();
    }
  }

  // Remove favorite from Firestore
  Future<void> removeFavorite(OrderModel item) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .collection('favorites')
            .doc(item.name)
            .delete();

        _favorites.removeWhere((favorite) => favorite.name == item.name);
        notifyListeners();
        await refreshFavorites();
      }
    } catch (e) {
      _error = 'Gagal menghapus favorit: $e';
      notifyListeners();
    }
  }

  // Check if item is favorite
  bool isFavorite(OrderModel item) {
    return _favorites.any((favorite) => favorite.name == item.name);
  }

  // Refresh favorites (e.g., after login)
  Future<void> refreshFavorites() async {
    await _loadFavorites();
  }
}
