import 'package:flutter/material.dart';


void main() {
  runApp(const Mywidget());
}
class Mywidget extends StatelessWidget {
  const Mywidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StefulPage(),
    );
  }
}
class StefulPage extends StatefulWidget {
  const StefulPage({Key? key}) : super(key: key);
  @override
  State<StefulPage> createState() => _StefulPageState();
}
class _StefulPageState extends State<StefulPage> {
  int count = 0;
  void decrement() {
    setState(() {
      count--;
    });
  }
  void increment() {
    setState(() {
      count++;
    });
  }
  bool get isEmpty => count == 0;
  bool get isFull => count == 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Imagappflutter.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFull ? 'LOTADO!!!':'Pode entrar !' ,
              style: TextStyle(
                fontSize: 50,
                color: isFull ? Colors.red : Colors.greenAccent,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(100),
              child: Text(
                '$count',
                style: TextStyle(
                  fontSize: 75,
                  color: isFull? Colors.red : Colors.green,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: isFull ? Colors.red : Colors.white,
                    fixedSize: const Size(150, 110),
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(200),
                    ),
                  ),
                  onPressed: isFull ? null : increment,
                  child:  Text(
                    isFull ? 'Já Chega!!' : 'Entrou',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: isEmpty ? Colors.green : Colors.white,
                      fixedSize: const Size(150, 110),
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(200),
                      )),
                  onPressed: isEmpty ? null: decrement,
                  child: Text(
                    isEmpty ? 'Clica no Mais :)':'Saiu',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}