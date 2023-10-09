import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login_app/core/constant/color.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Center(
          child: SizedBox(
        height: 30,
        width: 30,
        child: LoadingAnimationWidget.threeRotatingDots(
            color: ColorManager.primaryColor, size: 60),
      )),
    );
  }
}
