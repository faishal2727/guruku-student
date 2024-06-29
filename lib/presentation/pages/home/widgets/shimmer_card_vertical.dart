// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmerVertical extends StatelessWidget {
  const CardShimmerVertical({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
       
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: ShimmerCardUy(),
          );
        },
      ),
    );
  }
}

class ShimmerCardUy extends StatelessWidget {
  const ShimmerCardUy({Key? key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
   
      width: MediaQuery.of(context).size.width * 0.8, 
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 228, 227, 227),
        highlightColor: const Color.fromARGB(255, 201, 201, 201),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: const Center(
            child: Text(
              'Your Text',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
