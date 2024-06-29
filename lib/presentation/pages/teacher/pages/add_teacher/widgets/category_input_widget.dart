// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class CategoryInputWidget extends StatefulWidget {
  final String initialCategory;
  final TextEditingController otherCategoryController;
  final ValueChanged<String> onChanged;

  const CategoryInputWidget({
    Key? key,
    required this.initialCategory,
    required this.otherCategoryController,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CategoryInputWidgetState createState() => _CategoryInputWidgetState();
}

class _CategoryInputWidgetState extends State<CategoryInputWidget> {
  late String _selectedCategory;
  late bool _isOtherCategory;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _isOtherCategory = widget.initialCategory == 'lainnya';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              flex: 1,
              child: Text('Kategori Mengajar 🔅'),
            ),
            Expanded(
              flex: 3,
              child: DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: [
                  'IPA',
                  'IPS',
                  'MATEMATIKA',
                  'lainnya',
                ].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(category,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.ltr),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                    _isOtherCategory = _selectedCategory == 'lainnya';
                    widget.onChanged(_selectedCategory);
                  });
                },
                isExpanded: true,
                decoration: const InputDecoration(
                  hintText: 'Pilih kategori . . .',
                ),
              ),
            ),
          ],
        ),
        if (_isOtherCategory) const SizedBox(height: 16),
        if (_isOtherCategory)
          Row(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 3,
                child: TextFormField(
                  textAlign: TextAlign.end,
                  controller: widget.otherCategoryController,
                  decoration: const InputDecoration(
                    hintText: 'Masukan kategori lainnya . . .',
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(height: 16),
      ],
    );
  }
}
