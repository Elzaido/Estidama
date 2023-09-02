import 'package:flutter/material.dart';
import '../../widgets/appbar_widget.dart';

class Complains extends StatelessWidget {
  const Complains({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          defaultAppBar(context: context, title: 'تقديم بلاغ', isHome: false),
    );
  }
}
