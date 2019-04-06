import 'package:scoped_model/scoped_model.dart';
import '../models/product.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ConnectedProductsModel extends Model {
  int _selProductIndex;
  User _authenticatedUser;
  List<Product> _products = List();
  bool _isLoading = false;

  Future<Null> addProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': 'https://farm1.staticflickr.com/925/29200961038_aee56910d2.jpg',
      'price': price,
      'userId': _authenticatedUser.id,
      'userEmail': _authenticatedUser.email
    };

    return http
        .post('https://my-first-flutter-app-c933e.firebaseio.com/products.json',
            body: json.encode(productData))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: _authenticatedUser.email,
          userId: _authenticatedUser.id);

      _products.add(newProduct);
      _isLoading = false;
      notifyListeners();
    });
  }
}

class UsersModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '12345', email: email, password: password);
  }
}

class ProductsModel extends ConnectedProductsModel {
  bool _showFavorites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  Product get selectedProduct {
    if (selectedProductIndex == null) {
      return null;
    }
    return _products[selectedProductIndex];
  }

  void deleteProduct() {
    _products.removeAt(selectedProductIndex);
    notifyListeners();
  }

  void fetchProducts() {
    _isLoading = true;
    notifyListeners();
    http
        .get('https://my-first-flutter-app-c933e.firebaseio.com/products.json')
        .then((http.Response response) {
      final List<Product> fetchedProductList = List();
      final Map<String, dynamic> productListData = json.decode(response.body);
      if (productListData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            image: productData['image'],
            price: productData['price'],
            userId: productData['userId'],
            userEmail: productData['userEmail']);
        fetchedProductList.add(product);
      });
      _products = fetchedProductList;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> updateProduct(
      String title, String description, double price, String image) {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': 'https://farm1.staticflickr.com/925/29200961038_aee56910d2.jpg',
      'price': price,
      'userId': _authenticatedUser.id,
      'userEmail': _authenticatedUser.email
    };

    return http
        .put(
            'https://my-first-flutter-app-c933e.firebaseio.com/products/${selectedProduct.id}.json',
            body: json.encode(updateData))
        .then((http.Response response) {
      _isLoading = false;
      notifyListeners();
      final Product updatedProduct = Product(
          id: selectedProduct.id,
          title: title,
          description: description,
          price: price,
          image: image,
          userEmail: selectedProduct.userEmail,
          userId: selectedProduct.userId);
      _products[selectedProductIndex] = updatedProduct;
    });
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final bool isCurrentlyFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentlyFavorite;
    final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userId: selectedProduct.userId,
        userEmail: selectedProduct.userEmail,
        isFavorite: newFavoriteStatus);
    _products[selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }
}

class UtilityModel extends ConnectedProductsModel {
  bool get isLoading {
    return _isLoading;
  }
}
