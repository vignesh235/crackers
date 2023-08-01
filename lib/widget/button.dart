import 'dart:convert';

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class ElevateButton extends StatelessWidget {
  // const Elevatebutton({super.key});
  final String name;
  final Function onPressed;
  final GlobalKey<FormState> formKey;

  ElevateButton({
    super.key,
    required this.name,
    required this.onPressed,
    required this.formKey,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 343,
      height: 59,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textcolour,
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w700),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            onPressed();
          }
        },
        child: Text(name.toString()),
      ),
    );
  }
}
