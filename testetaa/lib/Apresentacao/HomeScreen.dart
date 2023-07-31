import 'package:flutter/material.dart';
import 'package:platform_detector/widgets/platform_type_widget.dart';
import 'package:testetaa/Apresentacao/TesteDeImpressora.dart';
import 'package:testetaa/Apresentacao/TesteDeWebCamScreen.dart';
import 'package:browser_launcher/browser_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Schalter Teste TAA', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: PlatformDetectByType(
          ifDesktop: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white
                      ),
                      iconSize: MaterialStateProperty.all(
                          200
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder:
                            (context) => TesteDeCamera(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          Text(
                            'Teste de camera',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 25,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white
                      ),
                      iconSize: MaterialStateProperty.all(
                          200
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder:
                            (context) => TesteDeImpressora(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.print,
                            color: Colors.black,
                          ),
                          Text(
                            'Teste de Impressora',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 25,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white
                      ),
                      iconSize: MaterialStateProperty.all(
                          200
                      ),
                    ),
                    onPressed: () async {
                      const _GertecUrl = 'https://sagat.gertec.com.br';
                      // Launches a chrome browser with two tabs open to [_googleUrl] and
                      // [_googleImagesUrl].
                      await Chrome.start([_GertecUrl,]);
                      print('launched Chrome');
                      // Pause briefly before opening Chrome with a debug port.
                      await Future<void>.delayed(const Duration(seconds: 3));
                      // Launches a chrome browser open to [_googleUrl]. Since we are launching with
                      // a debug port, we will use a variety of different launch configurations,
                      // such as launching in a new browser.
                      //final chrome = await Chrome.startWithDebugPort([_GertecUrl], debugPort: 8888);
                      print('launched Chrome with a debug port');
                      // When running this dart code, observe that the browser stays open for 3
                      // seconds before we close it.
                      await Future<void>.delayed(const Duration(seconds: 3));
                      //await chrome.close();
                      print('closed Chrome');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Colors.black,
                          ),
                          Text(
                            'Pinpad',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          ifMobile: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white
                      ),
                      iconSize: MaterialStateProperty.all(
                          150
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder:
                            (context) => TesteDeCamera(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          ),
                          Text(
                            'Teste de camera',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 25,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white
                      ),
                      iconSize: MaterialStateProperty.all(
                          150
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder:
                            (context) => TesteDeImpressora(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.print,
                            color: Colors.black,
                          ),
                          Text(
                            'Teste de Impressora',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 25,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white
                      ),
                      iconSize: MaterialStateProperty.all(
                          150
                      ),
                    ),
                    onPressed: () async {
                      abrirUrl();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Colors.black,
                          ),
                          Text(
                            'Pinpad',
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void abrirUrl() async {
    const url = 'https://sagat.gertec.com.br';
      await launch(url);
  }

}
