import 'package:flutter/material.dart';
import 'package:product_shop/data/models/product_model.dart';
import 'package:product_shop/presentation/pages/details_page.dart';

class ProductWidget extends StatefulWidget {
  final ProductModel product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailsPage(product: widget.product)),
          );
        },
        child: Container(
          margin:
              EdgeInsetsDirectional.symmetric(horizontal: screenWidth * 0.02),
          height: screenHeight * 0.30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: screenHeight * 0.20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.product.imageURL,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/product_placeholder.jpg', // Ruta de la imagen de reemplazo en tus activos
                          fit: BoxFit.fill,
                          width: double.infinity,
                        );
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 2, 6, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150,
                      height: 50, // Ajusta el ancho según tus necesidades
                      child: Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  '\$${widget.product.price}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color.fromARGB(255, 132, 131, 131),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
