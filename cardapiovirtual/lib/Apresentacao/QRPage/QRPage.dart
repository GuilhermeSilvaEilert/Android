
import 'package:cardapiovirtual/Apresentacao/widgets/ScaffoldMulticolor/ScaffoldMulticolor.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldMultiColor(
      TextAppBar: Text('QR-Code'),
      Body: Center(
        child: QrImageView(
          data: 'https://acessocardapio12.netlify.app/#/',
          version: QrVersions.auto,
          size: 400.0,
        ),
      ),
    );
  }
}
