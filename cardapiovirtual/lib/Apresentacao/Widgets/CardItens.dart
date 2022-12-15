import 'package:cardapiovirtual/Repository/ItemData.dart';
import 'package:flutter/material.dart';

class CardProduto extends StatelessWidget {
  const CardProduto({Key? key, required this.product}) : super(key: key);

  final ItemData product;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                product.images![0],
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      product.NomeDoProduto!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'R\$ ${product.PrecoDoProduto!.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
