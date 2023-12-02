import '../app/data/models/product_model.dart';
import 'constants.dart';

class DummyHelper {
  const DummyHelper._();

  static List<ProductModel> products = [
    ProductModel(
      product_id: 1,
      imagenes: [Constants.product1],
      name: 'The Basic Tee',
      quantity: 0,
      price: 25.99,
      rating: 4.5,
      reviews: '1.2k Reseñas',
      description: 'Descripción producto1',
      isFavorite: false,
    ),
    ProductModel(
        product_id: 2,
        imagenes: [Constants.product2],
        name: 'The Statement Skirt',
        quantity: 0,
        price: 79.99,
        rating: 4.4,
        reviews: '10k Reseñas',
        description: 'Descripción producto2',
        isFavorite: false),
    ProductModel(
        product_id: 3,
        imagenes: [Constants.product3],
        name: 'The Luxe Sweater',
        quantity: 0,
        price: 129.99,
        rating: 4.3,
        reviews: '22k Reseñas',
        description: 'Descripción producto3',
        isFavorite: false),
  ];
}
