import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (state is ProfileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileHasData) {
          return AvatarWidget(profile: state.result);
        } else if (state is ProfileEmpty) {
          return const Center(
            child: Text('Avatar Kosong'),
          );
        } else if (state is ProfileError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
