import 'package:flutter/material.dart';
import 'package:midtrans_snap/midtrans_snap.dart';
import 'package:midtrans_snap/models.dart';

class FaqPage extends StatefulWidget {
  static const ROUTE_NAME = '/faq_page';
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran"),
      ),
      body: MidtransSnap(
        mode: MidtransEnvironment.sandbox,
        token: '24e3f6a6-ae02-4feb-93ca-02e32c61016b',
        midtransClientKey: 'Mid-client-rLCqOVGroZ5F3OBM',
        onPageFinished: (url) {
          debugPrint(url);
        },
        onPageStarted: (url) {
          debugPrint(url);
        },
        onResponse: (result) {
          print(result.toJson());
        },
      ),
    );
  }
}



    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Faq'),
    //   ),
    //   body:  Column(
    //     children: [
    //       // const FaqWidgets(
    //       //   title: 'Mengapa Tidak Bisa Pesan ?',
    //       //   desc: 'mamammama',
    //       // ),

    //     ],
    //   ),
    // );