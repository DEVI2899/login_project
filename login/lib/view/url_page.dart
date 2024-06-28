import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UrlPage extends StatelessWidget {
  final String barcode;
  const UrlPage({super.key, required this.barcode,});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Url Screen'),
          centerTitle: true,
          backgroundColor: Colors.deepOrangeAccent,
        ),

        body: Column(
          children: [
            Center(
              child: SizedBox(
                width: 200,
                child: QrImageView(
                  data: barcode,
                  version: QrVersions.auto,

                  eyeStyle: const QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: Color(0xff128760),
                  ),
                  dataModuleStyle: const QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: Color(0xff1a5441),

                  ),
                 // embeddedImage: AssetImage('assets/images/4.0x/logo_yakka_transparent.png'),
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size.square(40),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Text(barcode, style: const TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}
