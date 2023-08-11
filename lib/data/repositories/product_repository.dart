import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_shop/data/models/product_model.dart';

abstract class ProductRepositoryBase {
  Future<void> addProduct(ProductModel product);
  Stream<List<ProductModel>> getProductsStream();
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String productId);
}

class ProductRepository implements ProductRepositoryBase {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');

  @override
  Future<void> addProduct(ProductModel product) async {
    await _productsCollection.add({
      'name': product.name,
      'imageUrl': product.imageURL,
      'stock': product.stock,
      'price': product.price,
      'description': product.description,
    });
  }

  @override
  Stream<List<ProductModel>> getProductsStream() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return ProductModel(
          id: doc.id,
          name: data['name'] ?? "Product",
          imageURL: data['imageUrl'] ??
              "https://cmsi-id.com/assets/product/01032016/pt-cahayatiara-mustika-scientific-indonesia_5tqwe_244.png",
          stock: data['stock'] ?? 0,
          price: data['price'] ?? 9.99,
          description: data['description'] ?? "Awesome product!",
        );
      }).toList();
    });
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _productsCollection.doc(product.id).update({
      'name': product.name,
      'imageUrl': product.imageURL,
      'stock': product.stock,
      'price': product.price,
      'description': product.description,
    });
  }

  @override
  Future<void> deleteProduct(String productId) async {
    await _productsCollection.doc(productId).delete();
  }
}
