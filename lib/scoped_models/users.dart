import '../models/user.dart';
import './connected_products.dart';

class UsersModel extends ConnectedProducts {
  void login(String email, String password) {
    authenticatedUser = User(id: '12345', email: email, password: password);
  }
}
