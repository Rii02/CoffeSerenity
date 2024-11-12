import 'package:coffeeapp/constants/constants.dart';
import 'package:coffeeapp/pages/cardProduct_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:coffeeapp/widgets/card_provider.dart';
import 'package:coffeeapp/widgets/order_model.dart';

enum Model {
  coffee,
  beans,
  coffeeMaker,
}

class CustomCard extends StatelessWidget {
  final Model model;
  final num numRate;
  final String nameProduct;
  final String descriptionProduct;
  final num priceProduct;
  final String nameImageFile;

  const CustomCard({
    super.key,
    required this.numRate,
    required this.nameProduct,
    required this.descriptionProduct,
    required this.priceProduct,
    required this.nameImageFile,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: InkWell(
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardproductPage(
                model: model,
                numRate: numRate,
                nameProduct: nameProduct,
                descriptionProduct: descriptionProduct,
                priceProduct: priceProduct,
                nameImageFile: nameImageFile,
              ),
            ),
          );
        },
        child: Container(
          width: 160, // Perbesar sedikit agar lebih leluasa
          height: 270,
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.69, -0.73),
              end: Alignment(-0.69, 0.73),
              colors: [Color(0xFF21262E), Color(0x0021262E)],
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFF21262E),
              ),
              borderRadius: BorderRadius.circular(23),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(23),
                      child: Image.asset(
                        "assets/images/$nameImageFile.jpg",
                        width: 136,
                        height: 136,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 22,
                        width: 53,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(23),
                            bottomLeft: Radius.circular(23),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/star.svg",
                              width: 12,
                              height: 12,
                            ),
                            Text(
                              "$numRate",
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    nameProduct,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    descriptionProduct,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              fontSize: 15,
                              color: Corange,
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: "Rp. "),
                              TextSpan(
                                text: priceProduct.toStringAsFixed(3),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Provider.of<CartProvider>(context, listen: false)
                            .addOrder(
                          OrderModel(
                            imagePath: "assets/images/$nameImageFile.jpg",
                            name: nameProduct,
                            size: "M",
                            description: descriptionProduct,
                            price: priceProduct.toDouble(),
                            quantity: 1,
                          ),
                        );
                      },
                      overlayColor: const MaterialStatePropertyAll(
                        Colors.transparent,
                      ),
                      child: Container(
                        width: 29,
                        height: 29,
                        decoration: BoxDecoration(
                          color: Corange,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.white,
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
    );
  }
}
