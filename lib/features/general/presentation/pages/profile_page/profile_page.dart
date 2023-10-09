import 'package:flutter/material.dart';
import 'package:login_app/core/constant/color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Profile Page',
          style: TextStyle(color: ColorManager.secondColor, fontSize: 30)),
    );
  }
}
