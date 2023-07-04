import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../responsive/responsive.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.question,
    required this.index,
    required this.totalQuestions,
  });
  final String question;
  final int index;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Question ${index + 1}/$totalQuestions: $question",
        style: TextStyle(
          fontSize: R.sw(22, context),
          color: neutral,
        ),
      ),
    );
  }
}
