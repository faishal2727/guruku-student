import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruku_student/common/constants.dart';
import 'package:guruku_student/common/enum_sate.dart';
import 'package:guruku_student/common/themes/themes.dart';
import 'package:guruku_student/presentation/blocs/order/order_bloc.dart';
import 'package:guruku_student/presentation/pages/pick_schedule/screen/order_succes_page.dart';

class ButtonOrder extends StatelessWidget {
  const ButtonOrder({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state.stateOrder == RequestStateOrder.loaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderSuccessPage(
                price: state.orderData!.data.grossAmount,
                expired: state.orderData!.data.expiryTime,
                vaNumbers: state.orderData!.data.vaNumber
                    .map((va) => {
                          'bank': va.bank,
                          'va_number': va.vaNumber,
                        })
                    .toList(),
              ),
            ),
          );
        } else if (state.stateOrder == RequestStateOrder.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state.stateOrder != RequestStateOrder.loading
                  ? onPressed
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006FD4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: state.stateOrder == RequestStateOrder.loading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Loading Order",
                          style: AppTextStyle.body3
                              .setMedium()
                              .copyWith(color: pr11),
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
      ),
    );
  }
}


