import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardUy extends StatelessWidget {
  const ShimmerCardUy({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 228, 227, 227),
        highlightColor: const Color.fromARGB(255, 201, 201, 201),
        child: Container(
          width: 100.0,
          height: 100.0,
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

class CardShimmerVertical extends StatelessWidget {
  const CardShimmerVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: 8,
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
