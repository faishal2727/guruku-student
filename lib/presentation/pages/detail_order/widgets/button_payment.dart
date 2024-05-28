import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/presentation/blocs/payment/payment_bloc.dart';

class ButtonPayment extends StatelessWidget {
  const ButtonPayment({
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
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.statePayment == RequestStatePayment.loading
                ? null
                : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006FD4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: state.statePayment == RequestStatePayment.loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Loading Request Token",
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
