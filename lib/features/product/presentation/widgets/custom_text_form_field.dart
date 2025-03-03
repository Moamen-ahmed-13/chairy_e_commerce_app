import 'package:chairy_e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.fieldName,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    required this.secured,
    required TextEditingController controller,
  });

  final bool secured;
  final String fieldName;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
        ),
        TextFormField(
          obscureText: secured,
          validator: validator,
          onSaved: onSaved,
          cursorColor: mainColor,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
              color: Colors.grey.shade300,
            )),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: mainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
