import 'package:cardapiovirtualmodulogarcom/Negocio/ChamadosIndividuais/ChamadosIndividuais.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class PegaChamado extends StatefulWidget {
  PegaChamado({
    Key? key,
    this.UserRoot,
    this.QuantidadePessoas,
    this.QuantidadeComandas,
    this.NumeroDaMesa,
    this.NumeroSenha,
    this.EmailGarcom,
    this.FuncaoAuxiliar
  }) : super(key: key);

  String? UserRoot;
  String? NumeroDaMesa;
  String? QuantidadeComandas;
  String? QuantidadePessoas;
  String? NumeroSenha;
  String? EmailGarcom;
  var FuncaoAuxiliar;

  @override
  State<PegaChamado> createState() => _PegaChamadoState();
}

class _PegaChamadoState extends State<PegaChamado> {

  ChamadosIndivisuais chamadosIndivisuais = ChamadosIndivisuais();

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          color: Color.fromARGB(255, 150, 0, 0),
          padding: EdgeInsets.all(8),
          width: 400,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Numero da Mesa: ${widget.NumeroDaMesa}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                'Quantidade de Comandas:${widget.QuantidadeComandas}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                'Quantidade de Pessoas:${widget.QuantidadePessoas}',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              ElevatedButton(
                  onPressed: widget.FuncaoAuxiliar,
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(400, 75)),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 150, 0, 0)
                    ),
                  ),
                  child: Text(
                      'Atender',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),
      ],
    );
  }

  MovimentaChamado(){

  }

}
