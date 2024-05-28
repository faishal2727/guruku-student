// ignore_for_file: use_super_parameters
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class ErrorSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String title;
  final String message;

  const ErrorSection({
    Key? key,
    required this.isLoading,
    required this.onPressed,
    this.title = 'Coba Lagi',
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error.png',
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: AppTextStyle.body3.setSemiBold(),
          ),
          Text(
            'Silahkan coba lagi beberapa saat...',
            style: AppTextStyle.body4.setRegular(),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FD4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: isLoading ? null : onPressed,
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    title,
                    style: AppTextStyle.body2.setSemiBold().copyWith(color: pr11),
                  ),
          ),
        ],
      ),
    );
  }
}
