import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/blocs/profile/profile_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';

class UpdatePage extends StatefulWidget {
  static const ROUTE_NAME = '/update_page';
  final DetailProfileResponse profile;
  const UpdatePage({Key? key, required this.profile}) : super(key: key);
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.profile.username ?? 'Data Belum Ada';
  }

  final GlobalKey<FormState> _updateProfileFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  void _updateProfile() {
    context.read<ProfileBloc>().add(
          OnUpdateProfileEvent(
              username: _usernameController.text,
              name: 'uhuy',
              email: 'aaa@gmail.com',
              phone: '010191918181',
              address: 'Jakarta',
              education: 'SMP',
              lat: '0.0',
              lon: '0.0',
              bod: DateTime.parse("2024-06-27T15:14:21.890Z")),
        );
  }

  void _submit() {
    if (_updateProfileFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _updateProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Update Profile',
          style: AppTextStyle.heading5.setSemiBold(),
        ),
        backgroundColor: pr11,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.stateAvatar == ReqStateAvatar.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    "Gagal Update Data",
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.stateAvatar == ReqStateAvatar.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Data berhasil diperbarui!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );

            Navigator.pop(context,true);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _updateProfileFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextFormField(
                  lable: 'Username',
                  key: const Key('username_field'),
                  controller: _usernameController,
                  hintText: 'Masukan Username mu...',
                  labelText: 'Username',
                  marginBottom: 16,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () {
                      _submit();
                    },
                    child: const Text('Update'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
