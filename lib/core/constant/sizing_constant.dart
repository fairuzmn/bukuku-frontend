import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Spacing tokens (base 4). Use for margins/paddings/gaps.
/// All values are responsive via .r (consistent with ScreenUtil).
abstract class AppSpacing {
  static double get space2 => 2.r;

  static double get space4 => 4.r;

  static double get space8 => 8.r;

  static double get space12 => 12.r;

  static double get space16 => 16.r;

  static double get space20 => 20.r;

  static double get space24 => 24.r;

  static double get space32 => 32.r;

  static double get space40 => 40.r;
}

/// Common radii (optional but handy)
abstract class AppRadius {
  static BorderRadius get xs => BorderRadius.circular(AppSpacing.space4);

  static BorderRadius get sm => BorderRadius.circular(AppSpacing.space8);

  static BorderRadius get md => BorderRadius.circular(AppSpacing.space12);

  static BorderRadius get lg => BorderRadius.circular(AppSpacing.space16);

  static BorderRadius get pill => BorderRadius.circular(999.r);
}

abstract class AppInsets {
  static EdgeInsets get mainContent => EdgeInsets.symmetric(horizontal: AppSpacing.space16);

  static EdgeInsets get bottomSheetContent => mainContent.copyWith(top: AppSpacing.space16);
}
