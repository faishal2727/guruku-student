// ignore_for_file: use_super_parameters, library_private_types_in_public_api, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/login/login_bloc.dart';
import 'package:guruku_student/presentation/blocs/main/main_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/screens/sign_up_page.dart';
import 'package:guruku_student/presentation/pages/auth/screens/req_forgot_password.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/my_text_form_field.dart';
import 'package:guruku_student/presentation/pages/auth/widgets/button_login.dart';
import 'package:guruku_student/presentation/pages/main/student_landing_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/teacher_landing_page.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  static const ROUTE_NAME = '/login-page';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordHide = true;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    context.read<LoginBloc>().add(
          DoLogin(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  void _submit() {
    if (_loginFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _login();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<LoginBloc>().add(DoAuthCheckEventk());
      context.read<MainBloc>().add(DoIsLoginEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.stateLogin == RequestStateLogin.error &&
            state.message.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red[400],
              ),
            );
        } else if (state.stateLogin == RequestStateLogin.loaded &&
            state.message.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          if (state.role == 'student') {
            Navigator.pushReplacementNamed(
              context,
              StudentLandingPage.ROUTE_NAME,
            );
          } else if (state.role == 'teacher') {
            Navigator.pushReplacementNamed(
              context,
              TeacherLandingPage.ROUTE_NAME,
            );
          }
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: context.select((LoginBloc bloc) => bloc.state.stateLogin == RequestStateLogin.loading),
        progressIndicator:const  CircularProgressIndicator(), // Ganti dengan indikator loading sesuai keinginan Anda
        child: Scaffold(
          backgroundColor: pr11,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Login',
              style: AppTextStyle.heading5.setRegular(),
            ),
            backgroundColor: pr11,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _loginFormKey,
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
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ReqForgotPasswordPage.ROUTE_NAME);
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Lupa Password ?',
                          style: AppTextStyle.body3
                              .setSemiBold()
                              .copyWith(color: pr13),
                        ),
                      ),
                    ),
                    ButtonLogin(
                      onPressed: _submit,
                      title: 'Masuk',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Belum memiliki akun? ',
                          style: AppTextStyle.body4.setMedium(),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpPage.ROUTE_NAME);
                          },
                          child: Text(
                            'Daftar di sini',
                            style: AppTextStyle.body4
                                .setBold()
                                .copyWith(color: pr13),
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
      ),
    );
  }
}
