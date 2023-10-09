import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_app/core/constant/color.dart';
import 'package:login_app/core/widgets/loading_widget.dart';
import 'package:login_app/features/general/presentation/bloc/profile/profile_bloc.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (state is ProfileLoadingState) {
        return const LoadingWidget();
      } else if (state is ProfileLoadedState) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            height: 168.w,
            decoration: BoxDecoration(
                color: ColorManager.primaryColor.withOpacity(.5),
                borderRadius: BorderRadius.circular(12.r)),
            child: Stack(children: [
              Center(
                child: SvgPicture.asset('assets/images/svg/user.svg'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 21.0.h, right: 20.w, left: 20.w),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text(
                            'Nom et prénom',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 12.r,
                                color: ColorManager.secondColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 2,
                          child: Text(': ${state.profile.name}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text('Profile',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text(': ${state.profile.profile}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text('Zone',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text(': ${state.profile.zone}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text('Secteur de contrôle',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          flex: 2,
                          child: Text(': ${state.profile.controlSector}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12.r,
                                  color: ColorManager.secondColor,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ]),
          ),
        );
      } else if (state is ProfileErrorState) {
        return Text(state.message);
      }
      return const LoadingWidget();
    });
  }
}
