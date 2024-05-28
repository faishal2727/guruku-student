import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';

class VerifyOtpForgotPwPage extends StatefulWidget {
  static const ROUTE_NAME = '/verify-otp-forgot-pw';
  final String email;

  VerifyOtpForgotPwPage({required this.email});

  @override
  _VerifyOtpForgotPwPageState createState() => _VerifyOtpForgotPwPageState();
}

class _VerifyOtpForgotPwPageState extends State<VerifyOtpForgotPwPage> {
  late List<TextStyle?> otpTextStyles;
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

  // void _verifyOtp() {
  //   String otp = '';
  //   for (TextEditingController? controller in controls) {
  //     if (controller != null && controller.text.isNotEmpty) {
  //       otp += controller.text;
  //     }
  //   }

  //   context
  //       .read<VerifyOtpBloc>()
  //       .add(DoVerifyOtpEvent(email: widget.email, otp: otp));
  // }

  // void _submit() {
  //   if (_verifiyOtpFormKey.currentState!.validate()) {
  //     FocusManager.instance.primaryFocus?.unfocus();
  //     _verifyOtp();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi OTP'),
      ),
      // body: BlocListener<VerifyOtpBloc, VerifyOtpState>(
      //   listener: (context, state) {
      //     if (state.stateVerifyOtp == RequestStateVerifyOtp.error) {
      //       ScaffoldMessenger.of(context)
      //         ..removeCurrentSnackBar()
      //         ..showSnackBar(
      //           SnackBar(
      //             content: const Text(
      //               'Gagal Verifikasi OTP',
      //               style: TextStyle(color: Colors.black),
      //             ),
      //             backgroundColor: Colors.red[400],
      //           ),
      //         );
      //     } else if (state.stateVerifyOtp == RequestStateVerifyOtp.loaded) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text(
      //             'Berhasil Verifikasi OTP!',
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           backgroundColor: Colors.green,
      //         ),
      //       );
      //       Navigator.pushNamed(context, LoginPage.ROUTE_NAME);
      //     }
      //   },
      // child:
      body: Container(
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

                  // _submit();

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
                    "Ini membantu kami memverifikasi setiap pengguna di apilikasi guruku",
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
              ElevatedButton(
                onPressed: canResendOtp
                    ? () {
                        // Implement your resend OTP logic here
                        setState(() {
                          _timerSeconds = 60;
                          canResendOtp = false;
                          startResendOtpTimer();
                        });
                      }
                    : null,
                child: Text(canResendOtp
                    ? "Kirim Ulang OTP"
                    : "Tunggu $_timerSeconds detik"),
              ),
              const Spacer(
                flex: 4,
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }

  @override
  void dispose() {
    _resendOtpTimer.cancel();
    super.dispose();
  }
}
