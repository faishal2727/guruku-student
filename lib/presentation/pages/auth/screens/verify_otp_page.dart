// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/refresh_otp/refresh_otp_bloc.dart';
import 'package:guruku_student/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:guruku_student/presentation/pages/auth/screens/login_page.dart';
class VerifyOtpPage extends StatefulWidget {
  static const ROUTE_NAME = '/verify-otp';
  final String email;

  VerifyOtpPage({required this.email});

  @override
  _VerifyOtpPageState createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  late List<TextEditingController?> controls;
  int numberOfFields = 6;
  bool clearText = false;
  final GlobalKey<FormState> _verifiyOtpFormKey = GlobalKey<FormState>();
  bool canResendOtp = false;
  late Timer _resendOtpTimer;
  int _timerSeconds = 60;

  @override
  void initState() {
    super.initState();
    startResendOtpTimer();
  }

  void startResendOtpTimer() {
    _resendOtpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          canResendOtp = true;
        });
        _resendOtpTimer.cancel();
      }
    });
  }

  void _verifyOtp() {
    String otp = '';
    for (TextEditingController? controller in controls) {
      if (controller != null && controller.text.isNotEmpty) {
        otp += controller.text;
      }
    }

    context
        .read<VerifyOtpBloc>()
        .add(DoVerifyOtpEvent(email: widget.email, otp: otp));
  }

  void _refreshOtp() {
    context.read<RefreshOtpBloc>().add(DorefreshOtp(email: widget.email));
  }

  void _submitRefreshOtp() {
    if (_verifiyOtpFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _refreshOtp();
    }
  }

  void _submit() {
    if (_verifiyOtpFormKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      _verifyOtp();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: pr11,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Verifikasi OTP',
          style: AppTextStyle.heading5.setRegular(),
        ),
        backgroundColor: pr11,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<VerifyOtpBloc, VerifyOtpState>(
            listener: (context, state) {
              if (state.stateVerifyOtp == RequestStateVerifyOtp.error) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Gagal Verifikasi OTP',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.red[400],
                    ),
                  );
              } else if (state.stateVerifyOtp == RequestStateVerifyOtp.loaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Berhasil Verifikasi OTP!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pushReplacementNamed(context, LoginPage.ROUTE_NAME);
              }
            },
          ),
          BlocListener<RefreshOtpBloc, RefreshOtpState>(
            listener: (context, state) {
              if (state.stateRefresh == RequestStateRefreshOtp.error) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: const Text(
                        'Gagal Mengirim Ulang OTP',
                        style: TextStyle(color: Colors.black),
                      ),
                      backgroundColor: Colors.red[400],
                    ),
                  );
              } else if (state.stateRefresh == RequestStateRefreshOtp.loaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Berhasil Mengirim Ulang OTP!',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                setState(() {
                  _timerSeconds = 60;
                  canResendOtp = false;
                  startResendOtpTimer();
                });
              }
            },
          ),
        ],
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _verifiyOtpFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Verifikasi Kode Otp",
                  style: AppTextStyle.heading3.setBold(),
                ),
                const SizedBox(height: 16),
                Text(
                  "Kami sudah mengirim kode OTP",
                  style: AppTextStyle.body2.setMedium(),
                ),
                Text(
                  "Ke email di bawah ini :",
                  style: AppTextStyle.body2.setMedium(),
                ),
                const Spacer(flex: 2),
                Center(
                  child: Text(
                    "email kamu :  ",
                    style: AppTextStyle.body2.setSemiBold(),
                  ),
                ),
                Center(
                  child: Text(
                    "${widget.email} ",
                    style: AppTextStyle.body2.setMedium(),
                  ),
                ),
                const SizedBox(height: 16),
                OtpTextField(
                  numberOfFields: numberOfFields,
                  focusedBorderColor: pr13,
                  clearText: clearText,
                  showFieldAsBox: true,
                  fillColor: pr13,
                  cursorColor: pr13,
                  enabledBorderColor: pr13,
                  textStyle: theme.textTheme.titleMedium,
                  onCodeChanged: (String value) {},
                  handleControllers: (controllers) {
                    controls = controllers;
                  },
                  onSubmit: (String verificationCode) {
                    setState(() {
                      clearText = true;
                    });

                    _submit();

                    // Reset clearText to false after a delay to allow the text fields to be cleared
                    Future.delayed(Duration(milliseconds: 100), () {
                      setState(() {
                        clearText = false;
                      });
                    });

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Verification Code",
                            style: AppTextStyle.body3.setMedium(),
                          ),
                          content: Text('Code entered is $verificationCode'),
                        );
                      },
                    );
                  },
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Ini membantu kami memverifikasi setiap pengguna di aplikasi Guruku",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.body3.setMedium(),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "Tidak mendapatkan kode OTP ?",
                    style: AppTextStyle.body3.setMedium(),
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: canResendOtp
                        ? () {
                            _submitRefreshOtp();
                          }
                        : null,
                    child: Text(canResendOtp
                        ? "Kirim Ulang OTP"
                        : "Tunggu $_timerSeconds detik"),
                  ),
                ),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _resendOtpTimer.cancel();
    super.dispose();
  }
}

