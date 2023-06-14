import 'package:acessocardapio/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:acessocardapio/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:flutter/material.dart';
import 'package:acessocardapio/Apresentacao/CardapioPage/CardapioPage.dart';

class DadosComanda extends StatefulWidget {
  DadosComanda({
    Key? key,
    this.UserRoot,
  }) : super(key: key);

  String? UserRoot;

  @override
  State<DadosComanda> createState() => _DadosComandaState();
}

class _DadosComandaState extends State<DadosComanda> {

  TextEditingController QuantidadeComandasController = TextEditingController();
  TextEditingController QuantidadePessoasController = TextEditingController();
  TextEditingController NumeroMesaController = TextEditingController();

  final _formValidateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar: Text('Preencha os dados para o Garçom'),
      Body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Form(
              key: _formValidateKey,
              child: Container(
                padding: const EdgeInsets.all(50),
                alignment: Alignment.topCenter,
                child: Column(
                    children:[
                      Container(
                        width: 425,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (text){
                            if(_formValidateKey.currentState!.validate()){}
                          },
                          controller: QuantidadeComandasController,
                          validator: (text) {
                            final exp = RegExp(
                                r'[0-9]',
                              multiLine: true,
                            );
                            if(!exp.hasMatch(text!)){
                              return 'Digite apenas numeros';
                            }
                          },
                          cursorColor: Colors.black,
                          decoration:InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Quantidade de comandas',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 425,
                        height: 70,
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (text){
                            if(_formValidateKey.currentState!.validate()){}
                          },
                          controller: QuantidadePessoasController,
                          validator: (text) {
                            final exp = RegExp(
                              r'[0-9]',
                              multiLine: true,
                            );
                            if(!exp.hasMatch(text!)){
                              return 'Digite apenas numeros';
                            }
                          },
                          cursorColor: Colors.black,
                          decoration:InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            // hoverColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Quantidade de pessoas',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: 425,
                        height: 70,
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          onChanged: (text){
                            if(_formValidateKey.currentState!.validate()){}
                          },
                          controller: NumeroMesaController,
                          validator: (text) {
                            final exp = RegExp(
                              r'[0-9]',
                              multiLine: true,
                            );
                            if(!exp.hasMatch(text!)){
                              return 'Digite apenas numeros';
                            }
                          },
                          cursorColor: Colors.black,
                          decoration:InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            // hoverColor: Colors.black,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:const BorderSide(color: Colors.black),
                            ),
                            hintText: 'Numero da Mesa',
                            counterStyle: const TextStyle(color: Colors.black),
                            labelStyle: const TextStyle(color: Colors.black,),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      TextButtonMultiColor(
                        funcao: () async {
                          if(_formValidateKey.currentState!.validate()){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CardapioPage(
                                  Email: widget.UserRoot,
                                  NumeroDaMesa: NumeroMesaController.text,
                                  QuantidadeComandas: QuantidadeComandasController.text,
                                  QuantidadePessoas: QuantidadePessoasController.text,
                                ),
                              ),
                            );
                          }
                        },
                        altura: 50,
                        largura: 200,
                        text: const Text('Encaminhar dados',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
