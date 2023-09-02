import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';

class Volunteering extends StatelessWidget {
  const Volunteering({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(
          context: context, title: 'تقديم للعمل التطوعي', isHome: false),
      body: const Column(
        children: [],
      ),
    );
  }
}
