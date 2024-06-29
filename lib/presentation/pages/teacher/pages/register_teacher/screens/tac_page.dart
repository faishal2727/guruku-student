// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class TacPage extends StatefulWidget {
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
        title: Text('Syarat dan Ketentuan'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
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
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      children: rules.map<Widget>((rule) {
        List<dynamic> content = rule['content'] ?? rule['rules'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: content.map<Widget>((item) {
            return ListTile(
              title: Text(item),
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}
