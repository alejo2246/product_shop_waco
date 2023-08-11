import 'package:flutter/material.dart';
import 'package:product_shop/data/models/product_model.dart';
import 'package:product_shop/data/repositories/product_repository.dart';
import 'package:product_shop/presentation/widgets/create_product_modal.dart';
import 'package:product_shop/presentation/widgets/edit_product_widget.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: Provider.of<ProductRepositoryBase>(context).getProductsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An error has occurred.'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No products available.'));
        } else {
          List<ProductModel> products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const CreateProductModal();
                          },
                        );
                      },
                      child: const Text('Create product'),
                    ));
              }
              final product = products[index - 1];
              return ListTile(
                title: Text(product.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return EditProductModal(product: product);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 4, 146, 28),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Product ${product.name}'),
                              content: const Text(
                                  'Are you sure you want to delete this product?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    try {
                                      await Provider.of<ProductRepositoryBase>(
                                              context,
                                              listen: false)
                                          .deleteProduct(product.id);
                                      Navigator.of(context).pop();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Product deleted!",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 2000),
                                          backgroundColor:
                                              Color.fromARGB(255, 9, 39, 0),
                                        ),
                                      );
                                    } catch (error) {
                                      print("Error deleting product: $error");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "An error occurred. Please try again later.",
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffffffff),
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 2000),
                                          backgroundColor:
                                              Color.fromARGB(255, 196, 16, 3),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 196, 16, 3),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
