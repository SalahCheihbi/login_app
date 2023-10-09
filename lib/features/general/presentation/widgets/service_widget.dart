import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:login_app/core/constant/color.dart';

Widget buildDefaultService({
  required String image,
  required String text,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 4,
                color: ColorManager.backgroundColor)
          ],
          borderRadius: BorderRadius.circular(
            12.r,
          )),
      child: Stack(
        children: [
          Row(children: [
            Container(
                height: 79.0.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12.r),
                      bottomLeft: Radius.circular(12.r),
                    ),
                    color: ColorManager.primaryColor.withOpacity(.3)),
                width: 80.w,
                child: Center(
                  child: Image.asset(
                    image,
                    height: 46.w,
                    width: 46.w,
                  ),
                )),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Urbanist',
                  color: ColorManager.secondColor,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ],
      ),
    ),
  );
}
