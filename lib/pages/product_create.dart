import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  Map<String, dynamic> _products = Map();
  String _title = '';
  String _description = '';
  double _price = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Product Title'),
            onChanged: (String value) {
              setState(() {
                _title = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Description'),
            maxLines: 3,
            onChanged: (String value) {
              setState(() {
                _description = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Product Price'),
            keyboardType: TextInputType.number,
            onChanged: (String value) {
              setState(() {
                _price = double.parse(value);
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            child: Text('Save'),
            onPressed: () {
              _products = {
                'title': _title,
                'description': _description,
                'price': _price,
                'image': 'assets/food.jpg'
              };
              widget.addProduct(_products);
              Navigator.pushReplacementNamed(context, '/productsPage');
            },
          ),
        ],
      ),
    );
  }
}
