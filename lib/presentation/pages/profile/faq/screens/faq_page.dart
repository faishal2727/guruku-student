import 'package:flutter/material.dart';
import 'package:guruku_student/presentation/pages/profile/faq/widgets/faq_widget.dart';

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
        title: const Text('Faq'),
      ),
      body: const Column(
        children: [
          FaqWidgets(
            title: 'Mengapa Tidak Bisa Pesan ?',
            desc: 'mamammama',
          ),
        ],
      ),
    );
  }
}
