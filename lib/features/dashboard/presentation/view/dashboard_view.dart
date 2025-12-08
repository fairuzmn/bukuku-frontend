import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/core/utils/alert/toaster_utils.dart';
import 'package:bukuku_frontend/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:bukuku_frontend/shared/gen/assets.gen.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppInsets.mainContent,
        child: SafeArea(
          child: SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.space8.verticalSpace,
                  Text(
                    "Master Data",
                    style: AppTypography.headline3.copyWith(),
                  ),
                  AppSpacing.space12.verticalSpace,
                  GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      menuContainer(
                        title: "User",
                        icon: Assets.icons.masterUser,
                        color: Color(0xFFefefff),
                        onTap: () {
                          ToasterUtils.showSuccess(message: "Coming Soon");
                        },
                      ),
                      menuContainer(
                        title: "Food",
                        icon: Assets.icons.masterFood,
                        color: Color(0xFFfff3ec),
                        onTap: controller.onTapFood,
                      ),
                      menuContainer(
                        title: "Category",
                        icon: Assets.icons.masterFoodCategory,
                        color: Color(0xFFe9fbee),
                        onTap: controller.onTapCategory,
                      ),
                      menuContainer(
                        title: "Table",
                        icon: Assets.icons.masterTable,
                        color: Color(0xFFeaf7ff),
                        onTap: controller.onTapTable,
                      ),
                    ],
                  ),
                  AppSpacing.space16.verticalSpace,
                  Text(
                    "Features",
                    style: AppTypography.headline3.copyWith(),
                  ),
                  AppSpacing.space12.verticalSpace,
                  GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      featureContainer(
                        title: "Order",
                        icon: Assets.icons.orderManagement,
                        color: Color(0xFFefefff),
                        onTap: controller.onTapOrder,
                      ),
                      featureContainer(
                        title: "History",
                        icon: Assets.icons.orderHistory,
                        color: Color(0xFFfff3ec),
                        onTap: controller.onTapHistory,
                      ),
                      featureContainer(
                        title: "Kitchen",
                        icon: Assets.icons.kitchenTicket,
                        color: Color(0xFFe9fbee),
                        onTap: controller.onTapKitchen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget menuContainer({
    required String title,
    required SvgGenImage icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: AppRadius.md,
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: .4.sw,
            height: 130.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon.svg(height: 50.h),
                AppSpacing.space8.verticalSpace,
                Text(
                  title,
                  style: AppTypography.paragraph3.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget featureContainer({
    required String title,
    required SvgGenImage icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ClipRRect(
      borderRadius: AppRadius.md,
      child: Material(
        color: color,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            width: .4.sw,
            height: 130.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                icon.svg(height: 35.h),
                AppSpacing.space8.verticalSpace,
                Text(
                  title,
                  style: AppTypography.paragraph4.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
