import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/dashboard/screens/dashboard_teacher_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/registration_form.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/screens/tac_page.dart';
import 'package:guruku_student/presentation/pages/teacher/pages/register_teacher/widgets/status_registration.dart';
import 'package:flutter/gestures.dart';

class WelcomeWidget extends StatefulWidget {
  final DetailProfileResponse data;
  const WelcomeWidget({
    super.key,
    required this.data,
  });

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.data.status == 'no-register') ...[
              Stack(
                children: [
                  Container(
                    color: pr13,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Center(
                    child: Image.asset('assets/images/pana.png',
                        height: MediaQuery.of(context).size.height * 0.3),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Hallo Selamat Datang ${widget.data.username} di GuruKu !',
                  style: AppTextStyle.heading5.setBold(),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Untuk mendaftar sebagai guru, mohon lengkapi informasi yang diperlukan, sebelum mendaftar harap baca dan cermati syarat dan ketentuan di bawah ini',
                  style: AppTextStyle.body3.setMedium(),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isTermsAccepted,
                    onChanged: (bool? value) {
                      setState(() {
                        isTermsAccepted = value ?? false;
                      });
                    },
                  ),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text: 'Saya menyetujui ',
                        style: AppTextStyle.body3
                            .setRegular()
                            .copyWith(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'syarat dan ketentuan',
                            style: AppTextStyle.body3.setRegular().copyWith(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const TacPage();
                                }));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: isTermsAccepted
                      ? () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RegistrationForm();
                          }));
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006FD4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Mulai Pendaftaran',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            ],
            if (widget.data.status != 'no-register' &&
                widget.data.status != 'acc') ...[
              const SizedBox(height: 32),
              Text(
                'Status Pendaftaran Kamu',
                style: AppTextStyle.body2.setMedium().setSemiBold(),
              ),
              StatusRegistration(data: widget.data),
            ],
            if (widget.data.status == 'acc') ...[
              DashboardTeacherPage(id: widget.data.teacher!.id),
            ],
          ],
        ),
      ],
    );
  }
}
