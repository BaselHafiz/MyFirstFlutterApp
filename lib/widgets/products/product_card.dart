import 'package:flutter/material.dart';

import 'price_tag.dart';
import 'package:my_first_flutter_app/widgets/products/title_default.dart';
import 'address_tag.dart';
import '../../models/product.dart';
import '../../scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  Widget _buildTitlePriceRow() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(child: TitleDefault(product.title)),
          Flexible(child: SizedBox(width: 20)),
          Flexible(child: PriceTag(product.price.toString())),
        ],
      ),
    );
  }

  Widget _buildRowForIconButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  model.selectProduct(product.id);
                  Navigator.pushNamed<bool>(context, '/product/' + product.id)
                      .then((_) => model.selectProduct(null));
                }),
            IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              onPressed: () {
                model.toggleProductFavoriteStatus(product);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Hero(
            tag: product.id,
            child: FadeInImage(
              image: NetworkImage(product.image),
              height: 300,
              fit: BoxFit.cover,
              placeholder: AssetImage('assets/food.jpg'),
            ),
          ),
          _buildTitlePriceRow(),
          SizedBox(
            height: 5,
          ),
          AddressTag(product.location.address),
          _buildRowForIconButtons(context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
