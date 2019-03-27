import 'package:flutter/material.dart';

import '../widgets/helpers/ensure_visible.dart.dart';
import '../models/product.dart';
import '../scoped_models/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg'
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Title is required';
          } else if (value.length < 5) {
            return 'Title should be 5+ characters';
          }
        },
        initialValue: product == null ? '' : product.title,
        decoration: InputDecoration(labelText: 'Product Title'),
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Description is required';
          } else if (value.length < 10) {
            return 'Description should be 10+ characters';
          }
        },
        initialValue: product == null ? '' : product.description,
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 3,
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Price is required';
          } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$')
              .hasMatch(value)) {
            return 'Price should be a number';
          } else if (double.parse(value.replaceFirst(RegExp(r','), '.')) < 50) {
            return 'Price should be \$ 50+';
          }
        },
        initialValue:
            product == null ? '' : product.price.toString(),
        decoration: InputDecoration(labelText: 'Product Price'),
        keyboardType: TextInputType.number,
        onSaved: (String value) {
          if (value.isNotEmpty &&
              RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
            _formData['price'] =
                double.parse(value.replaceFirst(RegExp(r','), '.'));
          }
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return RaisedButton(
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
          child: Text('Save'),
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.selectedProductIndex),
        );
      },
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, int selectedProductIndex) {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (selectedProductIndex == null) {
      addProduct(Product(
          title: _formData['title'],
          description: _formData['description'],
          image: _formData['image'],
          price: _formData['price']));
    } else {
      updateProduct(
          Product(
              title: _formData['title'],
              description: _formData['description'],
              image: _formData['image'],
              price: _formData['price']));
    }

    Navigator.pushReplacementNamed(context, '/productsPage');
  }

  Widget _buildPageContent(BuildContext context, Product product) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 650 : deviceWidth * 0.98;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        margin: EdgeInsets.all(15),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: targetPadding / 2,
              vertical: 10,
            ),
            children: <Widget>[
              _buildTitleTextField(product),
              _buildDescriptionTextField(product),
              _buildPriceTextField(product),
              SizedBox(height: 30),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        final Widget pageContent = _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
            ? pageContent
            : Scaffold(
                appBar: AppBar(
                  title: Text('Edit Product'),
                ),
                body: pageContent,
              );
      },
    );
  }
}
