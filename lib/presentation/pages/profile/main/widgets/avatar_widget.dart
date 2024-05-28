import 'package:flutter/material.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/pages/profile/update_avatar/update_avatar_page.dart';
import '../../../../../domain/entity/teacher/detail_profile_response.dart';

class AvatarWidget extends StatelessWidget {
  final DetailProfileResponse profile;
  const AvatarWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, UpdateAvatarPage.ROUTE_NAME);
          },
          child: Stack(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: ShapeDecoration(
                  shape: const OvalBorder(),
                  color: AppColors.primary.pr13,
                  image: DecorationImage(
                    image: NetworkImage(
                      profile.images ?? 'https://res.cloudinary.com/daqu7uzs2/image/upload/v1706018700/cld-sample-5.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: ShapeDecoration(
                      shape: const OvalBorder(), color: AppColors.primary.pr14),
                  child: Icon(
                    Icons.edit,
                    color: AppColors.primary.pr10,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(profile.username!,
            style: AppTextStyle.body2.copyWith(color: Colors.white)),
      ],
    );
  }
}
