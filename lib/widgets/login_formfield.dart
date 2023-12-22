import 'package:flutter/material.dart';

class LoginFormField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  const LoginFormField({
    Key? key,
    required this.theme,
    required this.validator,
    required this.controller,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.black54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: theme.colorScheme.error,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        labelText: labelText,
        labelStyle:
            theme.textTheme.labelMedium!.copyWith(color: Colors.black54),
        floatingLabelStyle:
            theme.textTheme.labelMedium!.copyWith(color: Colors.black),
        hintText: hintText,
        hintStyle: theme.textTheme.labelMedium!.copyWith(color: Colors.black54),
      ),
    );
  }
}
