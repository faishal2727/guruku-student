// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';

class ProfileListItem extends StatelessWidget {
  const ProfileListItem({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.menuProfile,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String menuProfile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: ShapeDecoration(
                  shape: const CircleBorder(),
                  color: AppColors.primary.pr14,
                ),
                child: Icon(
                  icon,
                  size: 25,
                  color: AppColors.primary.pr13,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                menuProfile,
                style: AppTextStyle.body3.setRegular(),
              ),
              const Spacer(),
              Icon(
                Icons.keyboard_arrow_right_outlined,
                color: AppColors.primary.pr13,
              )
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0.5,
            color: AppColors.primary.pr14,
          )
        ],
      ),
    );
  }
}
