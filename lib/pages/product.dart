import 'package:flutter/material.dart';
import 'dart:async';
import 'package:map_view/map_view.dart';
import 'package:my_first_flutter_app/widgets/products/title_default.dart';
import '../models/product.dart';
import '../widgets/products/product_fab.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  ProductPage(this.product);

  void _showMap() {
    final MapView mapView = MapView();
    final List<Marker> markers = <Marker>[
      Marker('position', 'position', product.location.latitude,
          product.location.longitude)
    ];
    final cameraPosition = CameraPosition(
        Location(product.location.latitude, product.location.longitude), 14);
    mapView.show(
      MapOptions(
          initialCameraPosition: cameraPosition,
          title: 'Product Loation',
          mapViewType: MapViewType.normal),
      toolbarActions: [ToolbarAction('Close', 1)],
    );

    mapView.onToolbarAction.listen((int id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });

    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
    });
  }

  Widget _buildAddressPriceRow(String address, double price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: Text(
            address,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'cambria',
            ),
          ),
          onTap: _showMap,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Text(
            '\$ ${price.toString()}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: 'cambria',
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 256.0,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(product.title),
                background: Hero(
                  tag: product.id,
                  child: FadeInImage(
                    image: NetworkImage(product.image),
                    height: 300,
                    fit: BoxFit.cover,
                    placeholder: AssetImage('assets/food.jpg'),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: TitleDefault(product.title),
                  ),
                  Container(
                    child: _buildAddressPriceRow(
                        product.location.address, product.price),
                  ),
                  Text(
                    product.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cambria',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: ProductFab(product),
      ),
    );
  }
}
