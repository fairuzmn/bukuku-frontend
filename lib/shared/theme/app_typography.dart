import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static TextStyle _inter(double size, FontWeight weight) {
    return GoogleFonts.inter(
      fontSize: size.sp,
      fontWeight: weight,
      color: AppColor.darkShade,
    );
  }

  // ---- Headlines ----
  static TextStyle get headline1 => _inter(35, FontWeight.w700);

  static TextStyle get headline2 => _inter(24, FontWeight.w700);

  static TextStyle get headline3 => _inter(20, FontWeight.w700);

  static TextStyle get headline4 => _inter(16, FontWeight.w600);

  static TextStyle get headline5 => _inter(14, FontWeight.w600);

  static TextStyle get headline6 => _inter(12, FontWeight.w600);

  // ---- Paragraph ----
  static TextStyle get paragraph1 => _inter(18, FontWeight.w500);

  static TextStyle get paragraph2 => _inter(16, FontWeight.w500);

  static TextStyle get paragraph3 => _inter(14, FontWeight.w400);

  static TextStyle get paragraph4 => _inter(12, FontWeight.w400);
}
