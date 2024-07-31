// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/blocs/req_forgot_pw/req_forgot_pw_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/button_req_email.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';

class ReqForgotPasswordPage extends StatefulWidget {
  static const ROUTE_NAME = '/req-forgot-password-page';

  const ReqForgotPasswordPage({super.key});

  @override
  State<ReqForgotPasswordPage> createState() => _ReqForgotPasswordPageState();
}

class _ReqForgotPasswordPageState extends State<ReqForgotPasswordPage> {
  final GlobalKey<FormState> _reqForgotPwFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _reqForgotPw() {
    context.read<ReqForgotPwBloc>().add(
          DoReqForgotPw(email: _emailController.text),
        );
  }

  void _submit() {
    if (_reqForgotPwFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _reqForgotPw();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lupa Password'),
        elevation: 0,
      ),
      body: BlocListener<ReqForgotPwBloc, ReqForgotPwState>(
        listener: (context, state) {
          if (state.stateReq == RequestStateReqForgotPw.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    'Gagal Kirim Email',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.stateReq == RequestStateReqForgotPw.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil Kirim Email !',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _reqForgotPwFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  MyTextFormField(
                    lable: 'Email',
                    key: const Key('email_field'),
                    controller: _emailController,
                    hintText: 'Masukan Email mu...',
                    labelText: 'Email',
                    marginBottom: 16,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email tidak boleh kosong!';
                      }
                      final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value);
                      if (!emailValid) {
                        return 'Email tidak valid!';
                      }
                      return null;
                    },
                  ),
                  ButtonReqEmail(
                    onPressed: _submit,
                    title: 'Kirim Email',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
