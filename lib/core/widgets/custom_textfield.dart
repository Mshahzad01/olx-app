import 'package:flutter/material.dart';
import '../utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SizeUtils.getProportionateScreenHeight(8),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeUtils.getProportionateScreenWidth(20),
            vertical: SizeUtils.getProportionateScreenHeight(16),
          ),
        ),
      ),
    );
  }
}
