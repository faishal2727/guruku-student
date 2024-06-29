import 'package:flutter/material.dart';

class ExperienceInputWidget extends StatelessWidget {
  final TextEditingController controller;
  const ExperienceInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 1,
          child: Text('Pengalaman (tahun/bulan) 🔅'),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Masukan pengalaman . . .',
            ),
             style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
