import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/pages/profile/main/widgets/avatar_widget.dart';

class AvatarContent extends StatefulWidget {
  const AvatarContent({super.key});

  @override
  State<AvatarContent> createState() => _AvatarContentState();
}

class _AvatarContentState extends State<AvatarContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileBloc>().add(OnProfileEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.stateProfile == ReqStateProfile.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.stateProfile == ReqStateProfile.loaded) {
          return AvatarWidget(profile: state.dataProfile!);
        } else if (state.stateProfile == ReqStateProfile.empty) {
          return Container(
            height: 150,
            color: pr13,
          );
        } else if (state.stateProfile == ReqStateProfile.error) {
          return Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: pr13,
            child: Center(child: Text('Error', style: AppTextStyle.body1.setMedium())),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
