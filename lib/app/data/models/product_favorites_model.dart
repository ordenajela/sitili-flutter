class FavItemModel {
  int favId;
  double price;
  double rating;
  String? seller;
  List<String>? images;
  String category;
  String productName;
  String comments;
  bool isFavorite; // Nuevo campo

  FavItemModel({
    required this.favId,
    required this.price,
    required this.rating,
    this.seller,
    this.images,
    required this.category,
    required this.productName,
    required this.comments,
    required this.isFavorite, 
  });

  factory FavItemModel.fromJson(Map<String, dynamic> json) {
    return FavItemModel(
      favId: json['fav_id'],
      price: json['precio'].toDouble(),
      rating: json['calificacion'].toDouble(),
      seller: json['vendedor'],
      images: List<String>.from(json['imagenes']),
      category: json['categoria'],
      productName: json['producto'],
      comments: json['comentarios'],
      isFavorite: false, 
    );
  }
}
