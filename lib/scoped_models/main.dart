import 'package:scoped_model/scoped_model.dart';
import './users.dart';
import './products.dart';

class MainModel extends Model with UsersModel, ProductsModel {}
