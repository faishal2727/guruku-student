import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardHorizontal extends StatelessWidget {
  const ShimmerCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ShimerCard(),
          );
        },
      ),
    );
  }
}

class ShimerCard extends StatelessWidget {
  const ShimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180.0,
      height: 200.0,
      child: Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 226, 225, 225),
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
