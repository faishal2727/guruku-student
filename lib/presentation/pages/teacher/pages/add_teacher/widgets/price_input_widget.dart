import 'package:flutter/material.dart';

class PriceInputWidget extends StatelessWidget {
  final TextEditingController controller;
  const PriceInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(flex: 1, child: Text('Harga Pertemuan 🔅')),
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: controller,
            textAlign: TextAlign.end,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Masukan harga pertemuan . . .',
            ),
             style:
                Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
