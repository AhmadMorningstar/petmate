import 'package:flutter/material.dart';
import 'package:petmate/const.dart';
import 'package:petmate/models/product_model.dart';
import 'package:petmate/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:petmate/provider/FavsProvider.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;
  const DetailPage({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  bool isAddedToCart = false;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    FavsProvider favsProvider = Provider.of<FavsProvider>(context);

    bool isFav = favsProvider.isFavorite(widget.product);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: black.withOpacity(0.7),
            size: 18,
          ),
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5 - 10,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.2,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              color: widget.product.color!,
                              offset: Offset.zero,
                              blurRadius: 100,
                              spreadRadius: 0)
                        ],
                      ),
                    ),
                  ),
                  Image.asset('assets/foods/${widget.product.image}'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name!,
                    style: poppin.copyWith(
                        fontSize: 18, color: black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.description!,
                    maxLines: 4,
                    style: poppin.copyWith(
                        height: 1.5, fontSize: 14, color: black.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: const Icon(Icons.add, color: grey)),
                            const SizedBox(width: 20),
                            Text(
                              '$quantity',
                              style: poppin,
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (quantity > 1) {
                                      quantity--;
                                    }
                                  });
                                },
                                child: const Icon(Icons.remove, color: grey)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${(quantity * widget.product.price!).toStringAsFixed(2)}',
                        style: poppin.copyWith(
                            fontSize: 32,
                            color: black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),

      // ✅ Updated Section: Bottom Navigation Bar
      bottomNavigationBar: Container(
        height: 90,
        color: white,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                favsProvider.toggleFavorite(widget.product);
              },
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_outline,
                size: 32,
                color: isFav ? Colors.red : grey,
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: GestureDetector(
                onTap: isAddedToCart
                    ? null
                    : () {
                  setState(() {
                    isAddedToCart = true;
                  });
                  cartProvider.addCart(widget.product, quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Added to cart'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  decoration: BoxDecoration(
                      color: green, borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.shopping_cart_outlined, color: white),
                      const SizedBox(width: 10),
                      Text(
                        isAddedToCart ? 'Added to cart' : 'Add to cart',
                        style: poppin.copyWith(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
