import 'package:flutter/material.dart';
import 'package:madenati/ui/widgets/appbar_widget.dart';

class Recycling extends StatelessWidget {
  const Recycling({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: 'إعادة التدوير'),
    );
  }
}
