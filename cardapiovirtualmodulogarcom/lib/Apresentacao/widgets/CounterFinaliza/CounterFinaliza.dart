import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CounterFinaliza extends StatefulWidget {
  CounterFinaliza({
    Key? key,
    this.UserRoot,
    this.QuantidadePessoas,
    this.QuantidadeComandas,
    this.NumeroDaMesa,
    this.NumeroSenha,
    this.EmailGarcom,
    this.FuncaoAuxiliar,
  }) : super(key: key);
  String? UserRoot;
  String? NumeroDaMesa;
  String? QuantidadeComandas;
  String? QuantidadePessoas;
  String? NumeroSenha;
  String? EmailGarcom;
  var FuncaoAuxiliar;
  var onPressed;
  @override
  State<CounterFinaliza> createState() => _CounterFinalizaState();
}

class _CounterFinalizaState extends State<CounterFinaliza> {

  final _isHours = true;
  bool? playepause = true;
  var tempoAtendendo;

  @override
  // TODO: implement widget
  CounterFinaliza get widget => super.widget;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    presetMillisecond: StopWatchTimer.getRawHours(1),
  );

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

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
            mainAxisAlignment:
            MainAxisAlignment.start,
            crossAxisAlignment:
            CrossAxisAlignment.start,
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
                  onPressed: () {
                    print('playepause: $playepause');
                    setState(() {
                      if (playepause == true) {
                        playepause = false;
                        _stopWatchTimer.onStartTimer();
                      } else if(playepause == false){
                        playepause = true;
                        _stopWatchTimer.onStopTimer();
                      }
                    });
                  },
                  style: ButtonStyle(
                    fixedSize:
                    MaterialStateProperty.all(
                        Size(400 , 40)
                    ),
                    backgroundColor:
                    MaterialStateProperty.all(
                      playepause == true
                          ? Color.fromARGB(
                          255, 150, 0, 0)
                          : Colors.green,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 30,
                        playepause == true
                            ? Icons.play_arrow
                            : Icons.pause,
                      ),
                      playepause == true
                          ? Text('')
                          : StreamBuilder<int>(
                        stream: _stopWatchTimer.rawTime,
                        initialData: _stopWatchTimer.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          final displayTime =
                          StopWatchTimer.getDisplayTime(value, hours: _isHours);
                          tempoAtendendo = displayTime;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment:  CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  displayTime,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )),
              SizedBox(height: 5,),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 150, 0, 0),
                      ),
                      fixedSize: MaterialStateProperty.all(
                          Size(400, 50)
                      )
                  ),
                  onPressed: () async {
                      if(playepause == true){
                        print('Tempo Atendimento: $tempoAtendendo');
                     await FirebaseFirestore
                            .instance
                            .collection('Usuario raiz')
                            .doc(widget.UserRoot)
                            .collection('Usuario Garçom')
                            .doc(widget.EmailGarcom)
                            .collection('Chamados')
                            .doc(widget.NumeroSenha)
                            .delete();

                       await widget.FuncaoAuxiliar;
                      }else{
                        onFail();
                        print('Pare o timer Antes');
                      }
                  },
                  child: Text(
                    'Finalizar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            ],
          ),
        ),
        SizedBox(height: 5,)
      ],
    );

  }


  onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Pare o Timer'
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
