import 'dart:async';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/CounterFinaliza/CounterFinaliza.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/PegaChamado/PegaChamado.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/ChamadosIndividuais/ChamadosIndividuais.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/Comandas/ApresentaComandas.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:cardapiovirtualmodulogarcom/Apresentacao/widgets/TextButtonMultiColor/TextButtonMultiColor.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/FirebaseNotification/FirebaseMessagins.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/FirebaseNotification/notification.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/Models/CardapioModel.dart';
import 'package:cardapiovirtualmodulogarcom/Negocio/VerificaChamada/VerificaChamada.dart';
import 'package:cardapiovirtualmodulogarcom/Repository/SQLiteDB.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:thread/thread.dart';

class HomeGarcom extends StatefulWidget {
  HomeGarcom({Key? key}) : super(key: key);

  @override
  State<HomeGarcom> createState() => _HomeGarcomState();
}

class _HomeGarcomState extends State<HomeGarcom> {

  int i = 1;
  SQLiteDB liteDB = SQLiteDB();
  bool? valor = false;
  final fcmToken = FirebaseMessaging.instance.getToken();
  String? UserRoot;
  Timer? countuptimer;
  bool? playepause = true;
  var tempoAtendendo;
  bool atendimento = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    presetMillisecond: StopWatchTimer.getMilliSecFromSecond(60 * 60),
  );

  ChamadosIndivisuais chamadosIndivisuais = ChamadosIndivisuais();

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessagins();
    checkNotifications();
  }

  @override
  void setState(VoidCallback atendimento) {
    // TODO: implement setState
    atendimento;
    super.setState(atendimento);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  initializeFirebaseMessagins() async {
    await Provider.of<FirebaseMessagins>(context, listen: false).initialize();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false)
        .checkForNotifications();
  }

  showNotification({String? title, String? body, int? id}) {
    setState(() {
      valor = !valor!;
      if (valor!) {
        Provider.of<NotificationService>(context, listen: false)
            .showNotification(
          CustomNotification(
              id: id, title: title, body: body, payload: '/home'),
        );
      }
    });
  }

  Endereco endereco = Endereco();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CardapioModel>(
      model: CardapioModel(),
      child: ScopedModelDescendant<CardapioModel>(
        builder: (context, child, model) {
          return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('Usuario Garcom')
                  .doc('Usuarios')
                  .collection(model.firebaseUser!.email!)
                  .get(),
              builder: (context, snapshot) {
                liteDB.getAllEmail().then((value) async {
                  if (value.isEmpty) {
                    await liteDB.initDb();
                    endereco.EmailEndereco =
                        await snapshot.data!.docs[0]['EmailRaiz'];
                    await liteDB.SaveEndereco(endereco);
                  }
                });
                liteDB.getEndereco(1).then((value) async {
                  UserRoot = await value!.EmailEndereco;
                  print('Email Raiz: $UserRoot');
                  print(value);
                });
                if (model.isLoading!) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  ProcuraChamados(UserRoot: UserRoot, iniciaBusca: true);
                  return ScaffoldMultiColor(
                    floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.refresh,
                      color: Colors.white,
                      ),
                      backgroundColor: Color.fromARGB(255, 150, 0, 0),
                      onPressed: (){
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('Usuario raiz')
                              .doc(UserRoot)
                              .collection('comandas').get();
                        });
                      },
                    ),
                      Body: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),

                    shrinkWrap: true,
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    width: 400,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 124, 112, 97)),
                                    child: Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Image.network(
                                              snapshot.data!.docs[0]['Imagem'],
                                              height: 100,
                                              width: 100,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Ola',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(
                                                    snapshot.data!.docs[0]
                                                        ['Nome'],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left:1),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        Color.fromARGB(
                                                            255, 150, 0, 0),
                                                      ),
                                                      fixedSize:
                                                          MaterialStateProperty
                                                              .all(Size(
                                                                  125, 50)),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              ApresentaComandas(
                                                            UserRoot: UserRoot,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'Ver Comandas',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: atendimento == true
                        ? Container()
                        : Container(
                          child: ElevatedButton(
                              child: Text('Voltar'),
                              onPressed: (){
                                setState(() {
                                  atendimento = true;
                                });
                              },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: atendimento == true?
                          FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('Usuario raiz')
                            .doc(UserRoot)
                            .collection('MesasAguardandoAtendimento')
                            .get(),
                        builder: (context, snapshot) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return PegaChamado(
                                EmailGarcom: model!.firebaseUser!.email,
                                UserRoot: UserRoot,
                                QuantidadePessoas: snapshot.data!.docs[index]['QuantidadePessoas'],
                                QuantidadeComandas: snapshot.data!.docs[index]['QuantidadeComandas'],
                                NumeroDaMesa: snapshot.data!.docs[index]['NumeroMesa'],
                                NumeroSenha: snapshot.data!.docs[index]['NumeroSenha'],
                                FuncaoAuxiliar: (){
                                  chamadosIndivisuais.CriaSenhaIndividualGarcom(
                                    UserRoot: UserRoot,
                                    EmailGarcom: model!.firebaseUser!.email,
                                    NumeroMesa: snapshot.data!.docs[index]['NumeroMesa'],
                                    QuantidadeComandas:snapshot.data!.docs[index]['QuantidadeComandas'],
                                    QuantidadePessoas: snapshot.data!.docs[index]['QuantidadePessoas'],
                                    ValorSenha: snapshot.data!.docs[index]['NumeroSenha'],
                                  );
                                  FirebaseFirestore
                                      .instance
                                      .collection('Usuario raiz')
                                      .doc(UserRoot)
                                      .collection('MesasAguardandoAtendimento')
                                      .doc(snapshot.data!.docs[index]['NumeroSenha']).delete();
                                 setState(() {
                                    atendimento = false;
                                  });
                                  onSucess();
                                },
                              );
                            },
                          );
                        },
                      ) :FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('Usuario raiz')
                                .doc(UserRoot)
                                .collection('Usuario Garçom')
                                .doc(model!.firebaseUser!.email)
                                .collection('Chamados')
                                .get(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return CounterFinaliza(
                                    UserRoot: UserRoot,
                                    QuantidadePessoas: snapshot.data!.docs[index]['QuantidadePessoas'],
                                    QuantidadeComandas: snapshot.data!.docs[index]['QuantidadeComandas'],
                                    NumeroDaMesa: snapshot.data!.docs[index]['NumeroMesa'],
                                    NumeroSenha: snapshot.data!.docs[index]['NumeroSenha'],
                                    EmailGarcom: model!.firebaseUser!.email,
                                    FuncaoAuxiliar: (){
                                      setState(() {
                                        atendimento = true;
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          )
                      )
                    ],
                  ));
                }
              });
        },
      ),
    );
  }

  colocaEstado(){
   /* setState(() {
      atendimento = true;
    });*/
  }

  onSucess() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Chamado Pego'
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  ProcuraChamados({
    bool? iniciaBusca,
    String? UserRoot,
  }) async {
    int? ChamadosJaGerados;

    final QuerySnapshot result = await Future.value(FirebaseFirestore.instance
        .collection('Usuario raiz')
        .doc(UserRoot)
        .collection('MesasAguardandoAtendimento')
        .orderBy('Time')
        .get());

    ChamadosJaGerados = await result.docs.length;

    print('Chamados ja gerados: $ChamadosJaGerados');

    while (iniciaBusca == true) {
      await Future.delayed(Duration(seconds: 1));
      print('UserRoot: $UserRoot');
      int? ChamadosNovos;
      final QuerySnapshot result2 = await Future.value(FirebaseFirestore
          .instance
          .collection('Usuario raiz')
          .doc(UserRoot)
          .collection('MesasAguardandoAtendimento')
          .orderBy('Time')
          .get());
      ChamadosNovos = await result2.docs.length;
      print('Chamados Novos: ${await ChamadosNovos}');

      if (ChamadosNovos > ChamadosJaGerados! && UserRoot!.isNotEmpty) {
        ChamadosJaGerados = ChamadosNovos;

        int? chamadosIndex;

        chamadosIndex = await ChamadosJaGerados! - 1;

        await FirebaseFirestore.instance
            .collection('Usuario raiz')
            .doc(UserRoot)
            .collection('MesasAguardandoAtendimento')
            .orderBy('Time')
            .get();

        print('ChamadosIndex: $chamadosIndex');
        print(
            'Numero da senha: ${await result2.docs[ChamadosJaGerados - 1]['NumeroSenha']}');
        print(
            'Numero da Mesa: ${await result2.docs[ChamadosJaGerados - 1]['NumeroMesa']}');

        showNotification(
            id: int.parse(
                await result2.docs[ChamadosJaGerados - 1]['NumeroSenha']),
            body: 'Dirija -se ao local',
            title:
                'Chamado da Mesa: ${await result2.docs[ChamadosJaGerados - 1]['NumeroMesa']}');
      } else if (ChamadosNovos < ChamadosJaGerados) {
        ChamadosJaGerados = ChamadosNovos;
      }
    }
  }
}
