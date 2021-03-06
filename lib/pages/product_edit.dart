import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_flutter_app/models/location_data.dart';
import 'dart:async';
import 'dart:io';
import '../widgets/helpers/ensure_visible.dart.dart';
import '../models/product.dart';
import '../scoped_models/main.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/form_inputs/location.dart';
import '../widgets/form_inputs/image.dart';
import '../widgets/products/adaptive_progress_indicator.dart';

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
    'image': null,
    'location': null
  };

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final TextEditingController _priceTextController = TextEditingController();

  Widget _buildTitleTextField(Product product) {
    if (product == null && _titleTextController.text.trim() == '') {
      _titleTextController.text = '';
    } else if (product != null && _titleTextController.text.trim() == '') {
      _titleTextController.text = product.title;
    } else if (product != null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else if (product == null && _titleTextController.text.trim() != '') {
      _titleTextController.text = _titleTextController.text;
    } else {
      _titleTextController.text = '';
    }

    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        controller: _titleTextController,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Title is required';
          } else if (value.length < 5) {
            return 'Title should be 5+ characters';
          }
        },
//        initialValue: product == null ? '' : product.title,
        decoration: InputDecoration(labelText: 'Product Title'),
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildDescriptionTextField(Product product) {
    if (product == null && _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = '';
    } else if (product != null &&
        _descriptionTextController.text.trim() == '') {
      _descriptionTextController.text = product.description;
    }

    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        controller: _descriptionTextController,
        focusNode: _descriptionFocusNode,
        validator: (String value) {
          if (value.isEmpty) {
            return 'Description is required';
          } else if (value.length < 10) {
            return 'Description should be 10+ characters';
          }
        },
//        initialValue: product == null ? '' : product.description,
        decoration: InputDecoration(labelText: 'Product Description'),
        maxLines: 3,
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    if (product == null && _priceTextController.text.trim() == '') {
      _priceTextController.text = '';
    } else if (product != null && _priceTextController.text.trim() == '') {
      _priceTextController.text = product.price.toString();
    }

    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        controller: _priceTextController,
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
//        initialValue: product == null ? '' : product.price.toString(),
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
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? Center(child: AdaptiveProgressIndicator())
            : RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text('Save'),
                onPressed: () => _submitForm(
                      model.addProduct,
                      model.updateProduct,
                      model.selectProduct,
                      model.selectedProductIndex,
                    ),
              );
      },
    );
  }

  void _setLocation(LocationData locData) {
    _formData['location'] = locData;
  }

  void _setImage(File image) {
    _formData['image'] = image;
  }

  void _submitForm(
      Function addProduct, Function updateProduct, Function setSelectedProduct,
      [int selectedProductIndex]) {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate() ||
        (_formData['image'] == null && selectedProductIndex == -1)) {
      return;
    }

    if (selectedProductIndex == -1) {
      addProduct(
        _titleTextController.text,
        _descriptionTextController.text,
        double.parse(_priceTextController.text.replaceFirst(RegExp(r','), '.')),
        _formData['image'],
        _formData['location'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      });
    } else {
      updateProduct(
        _titleTextController.text,
        _descriptionTextController.text,
        double.parse(_priceTextController.text.replaceFirst(RegExp(r','), '.')),
        _formData['image'],
        _formData['location'],
      ).then((bool success) {
        if (success) {
          Navigator.pushReplacementNamed(context, '/')
              .then((_) => setSelectedProduct(null));
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text('Please try again'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      });
    }
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
              SizedBox(height: 10),
              LocationInput(_setLocation, product),
              SizedBox(height: 10),
              ImageInput(_setImage, product),
              SizedBox(height: 10),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        final Widget pageContent =
            _buildPageContent(context, model.selectedProduct);

        return WillPopScope(
          onWillPop: () {
            Navigator.pushReplacementNamed(context, '/adminPage').then((_) {
              model.selectProduct(null);
            });
            return Future.value(true);
          },
          child: model.selectedProductIndex == -1
              ? pageContent
              : Scaffold(
                  appBar: AppBar(
                    elevation: Theme.of(context).platform == TargetPlatform.iOS
                        ? 0
                        : 5,
                    title: Text('Edit Product'),
                  ),
                  body: pageContent,
                ),
        );
      },
    );
  }
}
