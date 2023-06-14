import 'package:acessocardapio/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:acessocardapio/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:acessocardapio/Negocio/Model/ChamaGarcomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class ApresentaProduto extends StatefulWidget {
  ApresentaProduto({
    Key? key,
    required this.nome,
    required this.descricao,
    required this.imagem,
    required this.preco,
    this.NumeroDaMesa,
    this.QuantidadeComandas,
    this.QuantidadePessoas,
    this.Email,
  }) : super(key: key);

  String nome;
  String descricao;
  String imagem;
  double preco;
  String? QuantidadeComandas;
  String? QuantidadePessoas;
  String? NumeroDaMesa;
  String? Email;

  @override
  State<ApresentaProduto> createState() => _ApresentaProdutoState();
}

class _ApresentaProdutoState extends State<ApresentaProduto> {

  int? QuantidadeChamadasAtivas;
  ChamaGarcomModel chamaGarcomModel = ChamaGarcomModel();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      actions: TextButtonMultiColor(
        text: Text(
          'Chamar',
          style: TextStyle(color: Colors.white),
        ),
        funcao: () async {
          String now = DateTime.timestamp().hashCode.toString();
          String time = DateTime.timestamp().toString();
          final QuerySnapshot result = await Future.value(
              FirebaseFirestore.instance
                  .collection('Usuario raiz')
                  .doc(widget.Email)
                  .collection('MesasAguardandoAtendimento')
                  .get()
          );
          QuantidadeChamadasAtivas = await result.docs.length;
          print('chamados: $QuantidadeChamadasAtivas');
          print(widget.QuantidadeComandas);
          print(widget.QuantidadePessoas);
          print(widget.NumeroDaMesa);
          chamaGarcomModel.CriaSenhaGarcom(
            UserRoot: widget.Email,
            QuantidadeComandas: widget.QuantidadeComandas,
            QuantidadePessoas: widget.QuantidadePessoas,
            NumeroMesa: widget.NumeroDaMesa,
            time: time,
            onSucess: onSucess,
            onFail: onFail,
            ValorChamado: now.substring(4,),
          );
        },
        largura: 100,
        altura: 10,
      ),
      TextAppBar: Text(widget.nome),
      Body: Card(
        shadowColor: Colors.transparent,
        borderOnForeground: false,
        color: const Color.fromARGB(255, 124, 112, 97),
        child: Container(
          height: 500,
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageNetwork(
                image: widget.imagem,
                height: 300,
                width: 300,
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

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Chamada realizada'
        ),
        backgroundColor: Colors.green,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
  }

  onFail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Chamada não realizada'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}