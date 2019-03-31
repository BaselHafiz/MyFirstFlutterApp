import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import '../models/user.dart';

class ConnectedProducts extends Model {
  int selProductIndex;
  User authenticatedUser;
  List<Product> products = List();

  void addProduct(
      String title, String description, double price, String image) {
    final Product newProduct = Product(
        title: title,
        description: description,
        price: price,
        image: image,
        userEmail: authenticatedUser.email,
        userId: authenticatedUser.id);

    products.add(newProduct);
    selProductIndex = null;
  }
}