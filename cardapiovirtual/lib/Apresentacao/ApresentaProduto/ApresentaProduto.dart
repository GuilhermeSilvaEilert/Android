// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class ApresentaProdutos extends StatefulWidget {
  ApresentaProdutos({super.key, required this.nome,
    required this.descricao,
    required this.imagem,
    required this.preco});

  String nome;
  String descricao;
  String imagem;
  double preco;

  @override
  State<ApresentaProdutos> createState() => _ApresentaProdutosState();
}

class _ApresentaProdutosState extends State<ApresentaProdutos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 124, 112, 97),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 78, 90, 85),
        title: Text(widget.nome,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: widget.nome == null ? const Center(child: CircularProgressIndicator(),)
          :Card(
        shadowColor: Colors.transparent,
        borderOnForeground: false,
        color: const Color.fromARGB(255, 124, 112, 97),
        child: Container(
          height: 500,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                widget.imagem,
                fit: BoxFit.cover,
                width: 300,
                height: 300,
              ),
              const SizedBox(height: 20,),
              Container(
                height: 60,
                width: 400,
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 50,),
                    Text(widget.nome,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text('R\$ ${widget.preco}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(widget.descricao,
                  style: const TextStyle(
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
