import 'package:flutter/material.dart';

import '../../../../../common/themes/themes.dart';

class FaqWidgets extends StatefulWidget {
  final String title;
  final String desc;

  const FaqWidgets(
      {Key? key, required this.title, required this.desc})
      : super(key: key);

  @override
  State<FaqWidgets> createState() => _FaqWidgetsState();
}

class _FaqWidgetsState extends State<FaqWidgets>
    with SingleTickerProviderStateMixin {
  bool selected = false;
  late final animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(
              () {
                selected = !selected;
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.title,
                      style: AppTextStyle.body3.setMedium(),
                    ),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: selected ? 1 : 0,
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),
                Container(height: 1, color: Colors.grey.shade200),
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          switchInCurve: Curves.easeInSine,
          switchOutCurve: Curves.easeInSine,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: child,
            );
          },
          child: selected
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.desc,
                    style: AppTextStyle.body4.setRegular(),
                  ),
                )
              : null,
        ),
      ],
    );
  }
}
