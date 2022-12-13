import 'package:flutter/material.dart';

import '../Datas/product_data.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.product}) : super(key: key);

  final ProductData product;

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
