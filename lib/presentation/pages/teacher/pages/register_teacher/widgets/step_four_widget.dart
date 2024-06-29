import 'package:flutter/material.dart';

class StepFourWidget extends StatelessWidget {
  final TextEditingController typeTeachingController;

  const StepFourWidget({required this.typeTeachingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: typeTeachingController,
          decoration: InputDecoration(labelText: 'Tipe'),
        ),
      ],
    );
  }
}
