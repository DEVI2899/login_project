import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/view/url_page.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  String barcode = '';

  Future<void> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        barcode = result.rawContent; // Set the scanned barcode value
      });
    } catch (e) {
      setState(() {
        barcode = 'Failed to get barcode: $e';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Scanner'),
        centerTitle: true,
        backgroundColor: Colors.deepOrangeAccent,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 250,
              width: 300,
              child: MobileScanner(onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (kDebugMode) {
                    print(barcode.rawValue ?? "No Data found in QR");
                  }
                }
              }),
            ),
            ElevatedButton(onPressed: (){
               scanBarcode();

              },
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    minimumSize:const Size (250, 40),
                    backgroundColor: Colors.deepOrangeAccent
                ),
                child: const Text('submit')),
            ElevatedButton(onPressed: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> UrlPage(barcode:barcode)));
            },
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    minimumSize:const Size (250, 40),
                    backgroundColor: Colors.deepOrangeAccent
                ),
                child: const Text('url page')),

            const SizedBox(height: 20),
            const Text(
              'Scanned Barcode:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              barcode,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
