import 'package:flutter/material.dart';

import 'package:photo_view/photo_view.dart';
import 'package:product_shop/data/models/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Shop',
            style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              height: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.1), 
                    spreadRadius:
                        1, 
                    blurRadius: 2, 
                    offset: const Offset(
                        0, 2), 
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: PhotoView(
                  imageProvider: NetworkImage(widget.product.imageURL),
                  minScale: PhotoViewComputedScale.covered,
                  maxScale: PhotoViewComputedScale.covered * 2.5,
                  enableRotation: false,
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              width: double.infinity,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.product.name.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1b2028),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Product added to cart!",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xffffffff),
                              ),
                            ),
                            duration: Duration(milliseconds: 2000),
                            backgroundColor: Color.fromARGB(255, 9, 39, 0),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      ),
                    )
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Text(
                '\$${widget.product.price}',
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 35, 73, 0),
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Row(
                children: [
                  Icon(
                    widget.product.stock > 0 ? Icons.check : Icons.cancel,
                    color: widget.product.stock > 0 ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.product.stock > 0
                        ? '${widget.product.stock} unds.'
                        : 'No stock',
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color:
                          widget.product.stock > 0 ? Colors.green : Colors.red,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              width: double.infinity,
              child: Text(
                widget.product.description,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff000000),
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        )));
  }
}
