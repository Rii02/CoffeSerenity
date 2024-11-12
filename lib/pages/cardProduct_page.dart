import 'package:coffeeapp/constants/constants.dart';
import 'package:coffeeapp/widgets/custombuttontop.dart';
import 'package:coffeeapp/widgets/customcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coffeeapp/widgets/card_provider.dart';
import 'package:coffeeapp/widgets/order_model.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:coffeeapp/widgets/favoriteProvider.dart';

class CardproductPage extends StatefulWidget {
  final num numRate;
  final String nameProduct;
  final String descriptionProduct;
  final num priceProduct;
  final String nameImageFile;
  final Model model;

  const CardproductPage({
    super.key,
    required this.model,
    required this.numRate,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.priceProduct,
    required this.nameImageFile,
  });

  @override
  State<CardproductPage> createState() => _CardproductPageState();
}

class _CardproductPageState extends State<CardproductPage> {
  String selectedSize = 'M';
  final NumberFormat currencyFormat = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp. ',
    decimalDigits: 3,
  );

  void _addToCart() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final order = OrderModel(
      name: widget.nameProduct,
      price: widget.priceProduct.toDouble(),
      size: selectedSize,
      description: widget.descriptionProduct,
      quantity: 1,
      imagePath: "assets/images/${widget.nameImageFile}.jpg",
    );

    cart.addOrder(order);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${widget.nameProduct} added to cart!')),
    );
  }

  void _toggleFavorite() {
    final favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);
    final favoriteItem = OrderModel(
      name: widget.nameProduct,
      price: widget.priceProduct.toDouble(),
      size: selectedSize,
      description: widget.descriptionProduct,
      quantity: 1,
      imagePath: "assets/images/${widget.nameImageFile}.jpg",
    );

    if (favoriteProvider.isFavorite(favoriteItem)) {
      favoriteProvider.removeFavorite(favoriteItem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${widget.nameProduct} removed from favorites!')),
      );
    } else {
      favoriteProvider.addFavorite(favoriteItem);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.nameProduct} added to favorites!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite = favoriteProvider.isFavorite(OrderModel(
      name: widget.nameProduct,
      price: widget.priceProduct.toDouble(),
      size: selectedSize,
      description: widget.descriptionProduct,
      quantity: 1,
      imagePath: "assets/images/${widget.nameImageFile}.jpg",
    ));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/images/${widget.nameImageFile}.jpg",
                  width: double.maxFinite,
                  height: 600,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonTop(
                        models: Models.icon,
                        nameFileImage: "assets/icons/back.png",
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.white,
                        ),
                        onPressed: _toggleFavorite,
                      ),
                    ],
                  ),
                ),
                Positioned(
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
                                    widget.nameProduct,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    widget.descriptionProduct,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Cgray,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Cprimary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/coffee.svg",
                                          width: 32,
                                          height: 32,
                                        ),
                                        const Text(
                                          "Coffee",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Cgray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: Cprimary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/milk.svg",
                                          width: 32,
                                          height: 32,
                                        ),
                                        const Text(
                                          "Milk",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                            color: Cgray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/star.svg",
                                    width: 23,
                                    height: 23,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    "${widget.numRate}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "(6,454)",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Cgray,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: 132,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Cprimary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Medium Roasted",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Cgray,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Cgray,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Coffee is a rich, aromatic beverage made from roasted beans, offering bold flavors and warmth that energize body and mind.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Cgray,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['S', 'M', 'L'].map((size) {
                      return SizedBox(
                        width: 100,
                        height: 40,
                        child: ChoiceChip(
                          label: Text(size),
                          selected: selectedSize == size,
                          onSelected: (bool selected) {
                            setState(() {
                              selectedSize = selected ? size : selectedSize;
                            });
                          },
                          selectedColor: const Color(0XFF141414),
                          labelStyle: const TextStyle(color: Colors.white),
                          backgroundColor: const Color(0XFFB4B4B4),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Cgray,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            currencyFormat.format(widget.priceProduct),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 150,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 216, 154, 11),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _addToCart();
                          },
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
