import 'package:flutter/material.dart';

Widget profileButton(
    {required void Function()? onPressed,
    required String text,
    required Icon icon}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextButton(
              onPressed: onPressed,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  icon,
                ],
              )),
        ),
      ],
    ),
  );
}
