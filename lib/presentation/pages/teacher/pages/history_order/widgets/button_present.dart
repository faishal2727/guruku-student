
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/pages/teacher/blocs/order_teacher/order_teacher_bloc.dart';

class ButtonPresent extends StatelessWidget {
  const ButtonPresent({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
     
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: BlocBuilder<OrderTeacherBloc, OrderTeacherState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.statePresent == ReqPresent.loading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FD4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: state.statePresent == ReqPresent.loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Loading",
                        style: TextStyle(fontSize: 16),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText("..."),
                        ],
                      ),
                    ],
                  )
                : Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                  ),
          );
        },
      ),
    );
  }
}
