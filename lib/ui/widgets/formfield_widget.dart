import 'package:flutter/material.dart';

Widget formField(
        {required TextEditingController control,
        required bool isScure,
        required String label,
        required Icon prefIcon,
        ValueChanged<String>? onSubmit,
        required FormFieldValidator<String> validator,
        bool readOnly = false,
        Null Function()? ontap,
        IconButton? suffButton}) =>
    TextFormField(
      readOnly: readOnly,
      textDirection: TextDirection.rtl,
      validator: validator,
      controller: control,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isScure,
      obscuringCharacter: '*',
      onFieldSubmitted: onSubmit,
      onTap: ontap,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: prefIcon,
          suffixIcon: suffButton,
          hintText: label,
          hintStyle: const TextStyle(
            fontFamily: 'Cairo',
          ),
          hintTextDirection: TextDirection.rtl,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
