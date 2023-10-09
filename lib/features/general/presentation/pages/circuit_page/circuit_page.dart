import 'package:flutter/material.dart';
import 'package:login_app/core/constant/color.dart';

class CircuitPage extends StatelessWidget {
  const CircuitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Circuit Page',
          style: TextStyle(color: ColorManager.secondColor, fontSize: 30)),
    );
  }
}
