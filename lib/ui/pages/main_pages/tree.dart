import 'package:flutter/material.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';

class TreePlanting extends StatelessWidget {
  const TreePlanting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'إزرع شجرة'),
    );
  }
}
