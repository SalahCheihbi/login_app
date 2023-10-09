import 'package:flutter/material.dart';
import 'package:login_app/core/constant/color.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notification Page',
          style: TextStyle(color: ColorManager.secondColor, fontSize: 30)),
    );
  }
}
