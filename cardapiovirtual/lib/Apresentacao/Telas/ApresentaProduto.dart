import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApresentaProdutos extends StatelessWidget {
  ApresentaProdutos({required this.Nome,
    required this.Descricao,
    required this.Imagem,
    required this.Preco});

  String Nome;
  String Descricao;
  String Imagem;
  double Preco;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 124, 112, 97),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 78, 90, 85),
        title: Text(Nome,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Nome == null ? Center(child: CircularProgressIndicator(),)
          :Card(
        shadowColor: Colors.transparent,
        borderOnForeground: false,
        color: Color.fromARGB(255, 124, 112, 97),
        child: Container(
          height: 500,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                Imagem,
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
              SizedBox(height: 20,),
              Container(
                height: 60,
                width: 400,
                padding: EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 50,),
                    Text(Nome,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text('R\$ ${Preco}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Text(Descricao,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
