// ignore_for_file: use_super_parameters, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class EducationLevelInputWidget extends StatefulWidget {
  final List<String> initialLevels;
  final Function(List<String>) onChanged;

  const EducationLevelInputWidget({
    Key? key,
    required this.initialLevels,
    required this.onChanged,
  }) : super(key: key);

  @override
  _EducationLevelInputWidgetState createState() => _EducationLevelInputWidgetState();
}

class _EducationLevelInputWidgetState extends State<EducationLevelInputWidget> {
  late Set<String> _selectedLevels;

  @override
  void initState() {
    super.initState();
    _selectedLevels = widget.initialLevels.toSet();
  }

  void _handleCheckboxValueChange(String value, bool? isChecked) {
    setState(() {
      if (isChecked == true) {
        _selectedLevels.add(value);
      } else {
        _selectedLevels.remove(value);
      }
      widget.onChanged(_selectedLevels.toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Jenjang Ajar 🔅',
            style: AppTextStyle.body3.setMedium(),
          ),
          ListTile(
            title: const Text('SD'),
            leading: Checkbox(
              value: _selectedLevels.contains('SD'),
              onChanged: (isChecked) => _handleCheckboxValueChange('SD', isChecked),
            ),
          ),
          ListTile(
            title: const Text('SMP'),
            leading: Checkbox(
              value: _selectedLevels.contains('SMP'),
              onChanged: (isChecked) => _handleCheckboxValueChange('SMP', isChecked),
            ),
          ),
          ListTile(
            title: const Text('SMA/SMK'),
            leading: Checkbox(
              value: _selectedLevels.contains('SMA/SMK'),
              onChanged: (isChecked) => _handleCheckboxValueChange('SMA/SMK', isChecked),
            ),
          ),
          ListTile(
            title: const Text('SEMUA'),
            leading: Checkbox(
              value: _selectedLevels.contains('SEMUA'),
              onChanged: (isChecked) => _handleCheckboxValueChange('SEMUA', isChecked),
            ),
          ),
        ],
      ),
    );
  }
}
