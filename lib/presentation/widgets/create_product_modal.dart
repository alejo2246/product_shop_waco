import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:product_shop/data/models/product_model.dart';
import 'package:product_shop/data/repositories/product_repository.dart';
import 'package:product_shop/presentation/utils/image_uploader.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class CreateProductModal extends StatefulWidget {
  const CreateProductModal({Key? key}) : super(key: key);

  @override
  CreateProductModalState createState() => CreateProductModalState();
}

class CreateProductModalState extends State<CreateProductModal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final ImageUploader _imageUploader = ImageUploader();
  String imageUpload = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'name')),
          TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description')),
          TextField(
            controller: _stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Stock'),
          ),
          TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price')),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final pickedImage = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    final imageFile = File(pickedImage.path);
                    final downloadUrl =
                        await _imageUploader.uploadImage(imageFile);
                    if (downloadUrl != null) {
                      setState(() {
                        imageUpload = downloadUrl;
                      });
                    }
                  }
                },
                child: const Text('Upload Image'),
              ),
              const SizedBox(width: 10),
              Text(
                imageUpload != "" ? 'Image uploaded' : 'No image selected',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              if (_nameController.text.isEmpty ||
                  _descriptionController.text.isEmpty ||
                  _stockController.text.isEmpty ||
                  _priceController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Please complete all fields.",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffffffff),
                      ),
                    ),
                    duration: Duration(milliseconds: 2000),
                    backgroundColor: Color.fromARGB(255, 196, 16, 3),
                  ),
                );
              }
              final newProduct = ProductModel(
                name: _nameController.text,
                description: _descriptionController.text,
                stock: int.parse(_stockController.text),
                price: double.parse(_priceController.text),
                imageURL: imageUpload,
              );

              try {
                await Provider.of<ProductRepositoryBase>(context, listen: false)
                    .addProduct(newProduct);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Product created!",
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
              } catch (error) {
                ScaffoldMessenger.of(context).showSnackBar(
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
                    duration: Duration(milliseconds: 2000),
                    backgroundColor: Color.fromARGB(255, 196, 16, 3),
                  ),
                );
              }
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
