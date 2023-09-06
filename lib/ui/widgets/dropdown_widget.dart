import 'package:flutter/material.dart';

Widget dropDown(
        {required String selected,
        required List<String> list,
        required void Function(String?)? onChanged}) =>
    Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
            padding: const EdgeInsets.all(5),
            dropdownColor: const Color.fromARGB(255, 247, 247, 247),
            icon: const Icon(Icons.arrow_drop_down),
            isExpanded: true,
            iconSize: 22,
            style: const TextStyle(color: Colors.black, fontSize: 15),
            value: selected,
            underline: const SizedBox(),
            items: list.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      valueItem,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ));
