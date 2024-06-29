import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardHorizontal extends StatelessWidget {
  const ShimmerCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
 
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: 6,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
          padding: const EdgeInsets.only(top: 8),
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
