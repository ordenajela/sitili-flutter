class ProductModel {
  int product_id;
  List<String>? imagenes;
  String? name;
  int? quantity;
  double? price;
  double? rating;
  String? reviews;
  String? description;
  bool? isFavorite;

  ProductModel({
    required this.product_id,
    this.imagenes,
    this.name,
    this.quantity,
    this.price,
    this.rating,
    this.reviews,
    this.description,
    this.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      product_id: json['product_id'],
      imagenes: List<String>.from(json['imagenes']),
      name: json['producto'],
      quantity: json['cantidad'],
      price: json['precio'].toDouble(),
      rating: json['calificacion']?.toDouble(),
      reviews: json['comentarios'],
      description: json['categoria'],
      isFavorite: false,
    );
  }
}
