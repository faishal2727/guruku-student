// lib/common/utils/payment_utils.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Function to load payment methods from JSON file
Future<Map<String, dynamic>> loadPaymentMethods() async {
  // Load string from JSON file using rootBundle
  String jsonString = await rootBundle.loadString('assets/json/payment_instructions.json');
  // Decode JSON string into Dart object
  return json.decode(jsonString);
}

// Function to build payment method widgets based on the bank
List<Widget> buildPaymentMethods(BuildContext context, Map<String, dynamic>? paymentMethods, String bank) {
  List<Widget> paymentWidgets = [];
  final bankData = paymentMethods!['data'].firstWhere(
    (element) => element['bank'] == bank,
    orElse: () => null,
  );

  if (bankData != null) {
    final paymentMethods = bankData['payment_method'];
    paymentMethods.forEach((method) {
      method.forEach((methodName, steps) {
        paymentWidgets.add(
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              title: Text(
                "Petunjuk Transfer $methodName",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
              ),
              children: steps.map<Widget>((step) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      step,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      });
    });
  }

  return paymentWidgets;
}
