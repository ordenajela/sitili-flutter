class CartItemModel {
  int carId;
  double price;

  double rating;
  String? seller;
  List<String>? images;
  String category;
  String productName;
  String comments;

  CartItemModel({
    required this.carId,
    required this.price,
    required this.rating,
    this.seller,
    this.images,
    required this.category,
    required this.productName,
    required this.comments,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      carId: json['car_id'],
      price: json['precio'].toDouble(),
      rating: json['calificacion'].toDouble(),
      seller: json['vendedor'],
      images: List<String>.from(json['imagenes']),
      category: json['categoria'],
      productName: json['producto'],
      comments: json['comentarios'],
    );
  }
}
