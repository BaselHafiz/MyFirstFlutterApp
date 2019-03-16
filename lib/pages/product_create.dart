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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        } else if (value.length < 5) {
          return 'Title should be 5+ characters';
        }
      },
      decoration: InputDecoration(labelText: 'Product Title'),
      onSaved: (String value) {
        setState(() {
          _title = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required';
        } else if (value.length < 10) {
          return 'Description should be 10+ characters';
        }
      },
      decoration: InputDecoration(labelText: 'Product Description'),
      maxLines: 3,
      onSaved: (String value) {
        setState(() {
          _description = value;
        });
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is required';
        } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price should be a number';
        } else if (double.parse(value) < 50) {
          return 'Price should be \$ 50+';
        }
      },
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        setState(() {
          if (value.isNotEmpty &&
              RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            _price = double.parse(value);
          }
        });
      },
    );
  }

  void _submitForm() {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }
    _products = {
      'title': _title,
      'description': _description,
      'price': _price,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(_products);
    Navigator.pushReplacementNamed(context, '/productsPage');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 650 : deviceWidth * 0.98;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      margin: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: ListView(
          padding:
              EdgeInsets.symmetric(horizontal: targetPadding / 2, vertical: 10),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
            SizedBox(height: 30),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('Save'),
              onPressed: _submitForm,
            ),
          ],
        ),
      ),
    );
  }
}
