// ignore_for_file: use_super_parameters, library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/blocs/register/register_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/screens/verify_otp_page.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/button_register.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  static const ROUTE_NAME = '/register-page';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _passwordHide = true;
  bool _confirmPasswordHide = true;

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _register() {
    context.read<RegisterBloc>().add(
          DoRegister(
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _submit() {
    if (_registerFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _register();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Daftar'),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.stateRegister == RequestStateRegister.error) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: const Text(
                    'Gagal Register',
                    style: TextStyle(color: Colors.black),
                  ),
                  backgroundColor: Colors.red[400],
                ),
              );
          } else if (state.stateRegister == RequestStateRegister.loaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Berhasil Register!',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(context, VerifyOtpPage.ROUTE_NAME,
                arguments: _emailController.text);

          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _registerFormKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
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
                              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'Email tidak valid!';
                      }
                      return null;
                    },
                  ),
                  MyTextFormField(
                    lable: 'Password',
                    key: const Key('password_field'),
                    controller: _passwordController,
                    hintText: 'Masukan Password mu...',
                    labelText: 'Password',
                    marginBottom: 16,
                    obscureText: _passwordHide,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordHide = !_passwordHide;
                        });
                      },
                      icon: Icon(
                        _passwordHide ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 5) {
                        return 'Password min. 5 karakter';
                      }
                      return null;
                    },
                  ),
                  MyTextFormField(
                    lable: 'Konfirmasi Password',
                    key: const Key('confirm_password_field'),
                    controller: _confirmPasswordController,
                    hintText: 'Masukan Konfirmasi Password mu...',
                    labelText: 'Konfirmasi Password',
                    obscureText: _confirmPasswordHide,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confirmPasswordHide = !_confirmPasswordHide;
                        });
                      },
                      icon: Icon(
                        _confirmPasswordHide
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Konfirmasi Password tidak boleh kosong';
                      }
                      if (value.trim() != _passwordController.text.trim()) {
                        return 'Password tidak sama';
                      }
                      return null;
                    },
                  ),
                  ButtonRegister(
                    onPressed: _submit,
                    title: 'Daftar',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah memiliki akun? ',
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Masuk',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
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
