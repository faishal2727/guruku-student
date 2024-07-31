// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TacPage extends StatefulWidget {
  static const ROUTE_NAME = "/tac-page";
  const TacPage({Key? key}) : super(key: key);

  @override
  _TacPageState createState() => _TacPageState();
}

class _TacPageState extends State<TacPage> {
  late List<dynamic> definitions;
  late List<dynamic> guruRules;
  late List<dynamic> siswaRules;

  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String data = await rootBundle.loadString('assets/json/tac.json');
    Map<String, dynamic> jsonData = jsonDecode(data);
    setState(() {
      definitions = jsonData['syarat_dan_ketentuan']['definisi'];
      guruRules = jsonData['syarat_dan_ketentuan']['guru'];
      siswaRules = jsonData['syarat_dan_ketentuan']['siswa'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat dan Ketentuan'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Definisi', definitions),
            _buildSection('Guru', guruRules),
            _buildSection('Siswa', siswaRules),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<dynamic> rules) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Text(
          title,
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
        ),
        children: rules.map<Widget>((rule) {
          List<dynamic> content = rule['content'] ?? rule['rules'];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content.map<Widget>((item) {
              return ListTile(
                title: Text(item,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 12)),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
