import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class FaqPage extends StatefulWidget {
  static const ROUTE_NAME = '/faq_page';

  const FaqPage({Key? key}) : super(key: key);

  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  late Future<List<FaqItem>> _faqItems;

  @override
  void initState() {
    super.initState();
    _faqItems = FaqLoader.loadFaq();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Faq'),
      ),
      body: FutureBuilder<List<FaqItem>>(
        future: _faqItems,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FaqItem> faqItems = snapshot.data!;
            return ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                FaqItem faqItem = faqItems[index];
                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
                    title: Text(
                      faqItem.pertanyaan,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    children: faqItem.jawaban.map((jawaban) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            jawaban,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


class FaqLoader {
  static Future<List<FaqItem>> loadFaq() async {
    String data = await rootBundle.loadString('assets/json/faq.json');
    List<dynamic> jsonList = json.decode(data)['faq'];
    List<FaqItem> faqList = jsonList.map((item) => FaqItem.fromJson(item)).toList();
    return faqList;
  }
}

class FaqItem {
  final String pertanyaan;
  final List<String> jawaban;

  FaqItem({required this.pertanyaan, required this.jawaban});

  factory FaqItem.fromJson(Map<String, dynamic> json) {
    return FaqItem(
      pertanyaan: json['pertanyaan'],
      jawaban: List<String>.from(json['jawaban']),
    );
  }
}