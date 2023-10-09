import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_app/core/constant/color.dart';
import 'package:login_app/features/auth/presentation/widgets/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 2,
                width: double.infinity,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    ColorManager.primaryColor.withOpacity(0.7),
                    BlendMode.srcOver,
                  ),
                  child: Image.asset(
                    'assets/images/png/imgMaps_1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50.h),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/Group.svg',
                        semanticsLabel: 'Logo',
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      SvgPicture.asset(
                        'assets/images/svg/Vector.svg',
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Authentification',
                        style: TextStyle(
                          fontSize: 28.sp,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.06,
                      ),
                      const LoginFormWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
