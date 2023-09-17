import 'package:flutter/material.dart';
import '../../widgets/interface_components.dart';

class TreePlanting extends StatelessWidget {
  const TreePlanting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'إزرع شجرة'),
    );
  }
}
