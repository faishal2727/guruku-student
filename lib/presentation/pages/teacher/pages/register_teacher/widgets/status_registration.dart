import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/domain/entity/teacher/detail_profile_response.dart';

class StatusRegistration extends StatefulWidget {
  final DetailProfileResponse data;
  const StatusRegistration({
    super.key,
    required this.data,
  });

  @override
  State<StatusRegistration> createState() => _StatusRegistrationState();
}

class _StatusRegistrationState extends State<StatusRegistration> {
  int activeStep = 0;

  @override
  void initState() {
    super.initState();

    switch (widget.data.status) {
      case 'uploaded':
        activeStep = 0;
        break;
      case 'checking':
        activeStep = 1;
        break;
      case 'acc':
        activeStep = 2;
        break;
      case 'rejected':
        activeStep = 2;
        break;
      default:
        activeStep = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: activeStep,
      stepShape: StepShape.rRectangle,
      stepBorderRadius: 15,
      borderThickness: 2,
      padding: const EdgeInsets.all(10),
      stepRadius: 28,
      finishedStepBorderColor: pr13,
      finishedStepTextColor: pr13,
      finishedStepBackgroundColor: pr15,
      activeStepIconColor: pr13,
      showLoadingAnimation: false,
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 0 ? 1 : 0.3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/sending.png'),
              ),
            ),
          ),
          customTitle: const Text(
            'Terkirim',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 1 ? 1 : 0.3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/images/checking.png'),
              ),
            ),
          ),
          customTitle: const Text(
            'Pengecekan',
            textAlign: TextAlign.center,
          ),
        ),
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Opacity(
              opacity: activeStep >= 2 ? 1 : 0.3,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(widget.data.status == 'rejected'
                    ? 'assets/images/reject.png'
                    : 'assets/images/acc.png'),
              ),
            ),
          ),
          customTitle: Text(
            widget.data.status == 'rejected' ? 'Ditolak' : 'Diterima',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

        // WidgetsBinding.instance.addPostFrameCallback(
        //   (_) {
        //     Navigator.pushReplacement(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => DashboardTeacherPage(id: widget.data.id!),
        //       ),
        //     );
        //   },
        // );

// class DashboardTeacherPage extends StatefulWidget {
//   static const ROUTE_NAME = "/dashboard-teacher";
//   final int id;
//   const DashboardTeacherPage({
//     super.key,
//     required this.id,
//   });

//   @override
//   State<DashboardTeacherPage> createState() => _DashboardTeacherPageState();
// }

// class _DashboardTeacherPageState extends State<DashboardTeacherPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       context.read<MyDataTeacherBloc>().add(OnMyDataTeacherEvent(widget.id));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Detail Guru',
//           style: AppTextStyle.heading5.setRegular(),
//         ),
//         backgroundColor: pr11,
//       ),
//       body: BlocBuilder<MyDataTeacherBloc, MyDataTeacherState>(
//         builder: (context, state) {
//           if (state.state == RequestStateDetail.loading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state.state == RequestStateDetail.loaded) {
//             return DashboardContent(data: state.teacher!);
//           } else if (state.state == RequestStateDetail.empty) {
//             return const Center(
//               child: Text('kosong'),
//             );
//           } else if (state.state == RequestStateDetail.error) {
//             return const Center(
//               child: Text('error'),
//             );
//           } else {
//             return const SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }
