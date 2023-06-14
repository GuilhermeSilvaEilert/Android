import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:read_barcode/read_barcode.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final barcodeReader = BarcodeReader();
  String? code = '';
  bool enterPressed = false;

  void _listener() {
    setState(() {
      print(barcodeReader.keycode);
      barcodeReader.keycode.last == 'Enter'
          ? enterPressed = true
          : code = barcodeReader.keycode.join();
    });
  }

  @override
  Widget build(BuildContext context) {
    barcodeReader.addListener(_listener);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Barcode Reader Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  'Scan the barcode, scanned code will be displayed below'),
            ),
            Text(
              enterPressed ? code! : 'SCAN CODE',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    barcodeReader.removeListener(_listener);
    super.dispose();
  }
}