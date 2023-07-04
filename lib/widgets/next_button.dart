import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../responsive/responsive.dart';

class NextButton extends StatelessWidget {
  final VoidCallback nextQuestion;
  const NextButton({
    super.key,
    required this.nextQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nextQuestion,
      child: Container(
        width: R.sw(375, context),
        padding: EdgeInsets.symmetric(vertical: R.sh(10, context)),
        decoration: BoxDecoration(
          color: neutral,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Next Question",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
