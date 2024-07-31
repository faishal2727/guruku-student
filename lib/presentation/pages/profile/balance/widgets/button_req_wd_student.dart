
// ignore_for_file: use_super_parameters

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/blocs/withdraw/withdraw_bloc.dart';

class ButtonReqWdStudent extends StatelessWidget {
  const ButtonReqWdStudent({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: BlocBuilder<WithdrawBloc, WithdrawState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.stateWd != RequestStateWd.loading
                ? onPressed
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FD4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: state.stateWd == RequestStateWd.loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loading",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 16),
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
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 16, color: Colors.white),
                  ),
          );
        },
      ),
    );
  }
}
