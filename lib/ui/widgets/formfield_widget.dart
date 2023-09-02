import 'package:flutter/material.dart';

Widget formField(
        {required TextEditingController control,
        required bool isScure,
        required String label,
        required Icon prefIcon,
        ValueChanged<String>? onSubmit,
        required FormFieldValidator<String> validator,
        IconButton? suffButton}) =>
    TextFormField(
      textDirection: TextDirection.rtl,
      validator: validator,
      controller: control,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isScure,
      obscuringCharacter: '*',
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: prefIcon,
          suffixIcon: suffButton,
          hintText: label,
          hintTextDirection: TextDirection.rtl,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
