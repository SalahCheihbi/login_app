import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:login_app/core/constant/color.dart';
import 'package:login_app/core/utils/snackbar_message.dart';
import 'package:login_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:login_app/features/general/presentation/pages/main_menu/menu_main_page.dart';

class LoginFormWidget extends HookWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    ValueNotifier<bool> isPassword = useState(false);
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final TextEditingController emailController = TextEditingController(
      text: "a.mouchrif@gmail.com",
    );
    final TextEditingController passwordController = TextEditingController(
      text: "mouchrif1234",
    );
    ValueNotifier<bool> showCircularProgress = useState(false);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuMainPage()),
          );
          showCircularProgress.value = false;
        } else if (state is LoginErrorState) {
          showCircularProgress.value = false;
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        } else if (state is LoginLoadingState) {
          showCircularProgress.value = true;
        }
      },
      child: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 55),
                      height: 340.w,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorManager.whiteColor,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 4),
                                color: const Color(0xffF5F5F5).withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 12)
                          ]),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 81, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    ColorManager.primaryColor.withOpacity(.1),
                                border: Border.all(
                                    color: ColorManager.primaryColor
                                        .withOpacity(.1)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email is Empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    color: ColorManager.dangerColor,
                                  ),
                                  hintText: 'Type your Email',
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              'Password',
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    ColorManager.primaryColor.withOpacity(.1),
                                border: Border.all(
                                    color: ColorManager.primaryColor
                                        .withOpacity(.1)),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: TextFormField(
                                obscuringCharacter: "*",
                                controller: passwordController,
                                obscureText: !isPassword.value,
                                onSaved: (value) {
                                  passwordController.text;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password is Empty';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Type your Password',
                                  border: InputBorder.none,
                                  suffixIconColor: ColorManager.grayColor,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      isPassword.value = !isPassword.value;
                                    },
                                    icon: const Icon(Icons.visibility),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {},
                                child: Text('Forgot Password ?',
                                    style: TextStyle(
                                        color: ColorManager.primaryColor)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 12,
                          spreadRadius: 4,
                          color: ColorManager.backgroundColor.withOpacity(0.5),
                        )
                      ]),
                      child: GestureDetector(
                        onTap: () {
                          showCircularProgress.value = true;
                          if (formKey.currentState!.validate()) {
                            loginBloc.add(LoginCheckEvent(
                                email: emailController.text,
                                password: passwordController.text));
                          }
                        },
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: ColorManager.whiteColor,
                          child: CircleAvatar(
                            backgroundColor: ColorManager.primaryColor,
                            radius: 40,
                            child: showCircularProgress.value == true
                                ? Center(
                                    child: LoadingAnimationWidget
                                        .threeArchedCircle(
                                            color: ColorManager.secondColor,
                                            size: 25))
                                : SvgPicture.asset(
                                    'assets/images/svg/Arrow_1.svg'),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Text(
                      'Or Login with',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorManager.secondColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 42.w,
                            width: 140.w,
                            decoration: BoxDecoration(
                                color: ColorManager.blueColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Facebook',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: ColorManager.whiteColor,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SvgPicture.asset(
                                      'assets/images/svg/Fb_logo.svg'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 42.w,
                            width: 140.w,
                            decoration: BoxDecoration(
                                color: ColorManager.dangerColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                      'assets/images/svg/Google_logo.svg'),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text('Google',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: ColorManager.whiteColor,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
