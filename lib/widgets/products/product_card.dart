import 'package:flutter/material.dart';

import 'price_tag.dart';
import 'package:my_first_flutter_app/widgets/products/title_default.dart';
import 'address_tag.dart';
import '../../models/product.dart';
import '../../scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(
            width: 20,
          ),
          PriceTag(product.price.toString()),
        ],
      ),
    );
  }

  Widget _buildRowForIconButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
                context,
                '/product/' + productIndex.toString(),
              ),
        ),
        ScopedModelDescendant<MainModel>(
          builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(model.allProducts[productIndex].isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.selectProduct(productIndex);
                model.toggleProductFavoriteStatus();
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.network(product.image),
          _buildTitlePriceRow(),
          AddressTag('Union Square, San Fransisco'),
          _buildRowForIconButtons(context),
          Text(product.userEmail),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
