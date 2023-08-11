class ProductModel {
  String id;
  String imageURL;
  String description;
  double price;
  String name;
  int stock;

  ProductModel(
      {this.id = "",
      required this.description,
      required this.stock,
      required this.price,
      required this.name,
      this.imageURL =
          'https://media.istockphoto.com/id/1126929389/es/foto/composici%C3%B3n-con-los-productos-comestibles-frescos-vegetariano.jpg?s=2048x2048&w=is&k=20&c=ayD9NKvEUypbacLmJNTq2re4uEDDKBaJXjpyuMxwlaU='});
}
