import 'package:flutter/material.dart';
import 'package:superadm/Apresentacao/ApresentaCategorias/ApresentaCategorias.dart';
import 'package:superadm/Apresentacao/CadastraItens/CadastroDeItens.dart';
import 'package:superadm/Apresentacao/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:superadm/Apresentacao/TextButtonMultiColor/TextButtonMultiColor.dart';

import '../CriaCategorias/CriaCategorias.dart';

class Opcoes extends StatefulWidget {
  Opcoes({
    Key? key,
    this.Empresa,
    this.Imagem,
    this.endereco,
    this.numero,
    this.estado,
    this.cidade,
    this.categoria,
    this.id,
  }) : super(key: key);

  String? Empresa;
  String? Imagem;
  String? endereco;
  String? numero;
  String? estado;
  String? cidade;
  String? categoria;
  String? id;

  @override
  State<Opcoes> createState() => _OpcoesState();
}

class _OpcoesState extends State<Opcoes> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar: Text('Cardapio'),
      Body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                color: Color.fromARGB(255, 124, 112, 97),
                child: Row(
                  children: [
                    Image.network(
                      '${widget.Imagem}',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text(
                              '${widget.Empresa}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 250,
                          padding: EdgeInsets.all(8),
                          child: Text(
                              'Endereço: ${widget.endereco}, ${widget.cidade}, ${widget.numero}, ${widget.estado}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButtonMultiColor(
                    text: Text(
                      'Ver Cardapio',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    altura: 50,
                    funcao: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApresentaCategorias(
                        Empresa: widget.Empresa,
                      ),));
                    },
                    largura: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButtonMultiColor(
                    text: Text(
                      'Adicionar Categorias',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    altura: 50,
                    funcao: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CriaCategoria(
                        Empresa: widget.Empresa,
                      ),));
                    },
                    largura: 400,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButtonMultiColor(
                    text: Text(
                      'Adicionar Itens',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    altura: 50,
                    funcao: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CadastraItem(
                          Empresa: widget.Empresa,
                          id: widget.id,
                          categoria: widget.categoria,
                      ),));
                    },
                    largura: 400,
                  ),
                )
              ],
            ),
          ],
        )
      ),
    );
  }
}
