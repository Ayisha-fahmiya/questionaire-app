import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../responsive/responsive.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    super.key,
    required this.option,
    required this.color,
    required this.ontap,
  });
  final String option;
  final VoidCallback ontap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color ?? neutral,
      child: ListTile(
        onTap: ontap,
        title: Text(
          option,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: R.sw(20, context),
          ),
        ),
      ),
    );
  }
}
