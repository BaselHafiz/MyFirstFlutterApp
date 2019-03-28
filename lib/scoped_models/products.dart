import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';

class ProductsModel extends Model {
  List<Product> _products = List();
  int _selectedProductIndex;

  List<Product> get products => List.from(_products);

  int get selectedProductIndex => _selectedProductIndex;

  Product get selectedProduct {
    if (_selectedProductIndex == null)
      return null;
    else
      return _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void updateProduct(Product newProduct) {
    _products[_selectedProductIndex] = newProduct;
    _selectedProductIndex = null;
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        isFavorite: newFavoriteStatus);
    _products[_selectedProductIndex] = updatedProduct;
    _selectedProductIndex = null;
    notifyListeners();
  }
}
