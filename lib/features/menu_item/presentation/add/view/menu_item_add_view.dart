import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/menu_item/domain/entity/menu_item_entity.dart';
import 'package:bukuku_frontend/features/menu_item/presentation/add/controller/menu_item_add_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/components/form/text_input.dart';
import 'package:bukuku_frontend/shared/components/form/text_input_dropdown.dart';
import 'package:bukuku_frontend/shared/components/image/image.dart';
import 'package:bukuku_frontend/shared/theme/app_color.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MenuItemAddView extends GetView<MenuItemAddController> {
  const MenuItemAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    Text(
                      "Add Food",
                      style: AppTypography.headline3.copyWith(),
                    ),
                  ],
                ),
                Padding(
                  padding: AppInsets.mainContent,
                  child: Column(
                    children: [
                      AppSpacing.space16.verticalSpace,
                      GestureDetector(
                        onTap: controller.choseImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.darkShade10,
                            borderRadius: AppRadius.md,
                          ),
                          height: 200.h,
                          width: 1.sw,
                          child: Center(
                            child: Obx(
                              () {
                                if (controller.selectedImage.value != null) {
                                  return AppImage(
                                    path: controller.selectedImage.value!.path,
                                    fit: BoxFit.cover,
                                    height: 200.h,
                                  );
                                }

                                return Text(
                                  "Add Image",
                                  style: AppTypography.headline4.copyWith(color: AppColor.darkShade75),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      AppSpacing.space16.verticalSpace,
                      Obx(
                        () => AppTextInput(
                          hint: "Name",
                          controller: controller.nameController,
                          errorText: controller.nameError.value,
                          onChanged: (e) => controller.nameError.value = null,
                        ),
                      ),
                      AppSpacing.space16.verticalSpace,
                      Obx(
                        () => AppTextInput(
                          hint: "Description",
                          controller: controller.descController,
                          errorText: controller.descError.value,
                          onChanged: (e) => controller.descError.value = null,
                        ),
                      ),
                      AppSpacing.space16.verticalSpace,
                      Obx(
                        () => AppTextInput(
                          hint: "Price",
                          controller: controller.priceController,
                          errorText: controller.priceError.value,
                          onChanged: (e) => controller.priceError.value = null,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      AppSpacing.space16.verticalSpace,
                      Obx(
                        () => TextInputDropdown(
                          label: 'Category',
                          data: controller.categories.map((e) => SelectedListItem(data: e.name)).toList(),
                          controller: controller.categoryController,
                          errorText: controller.statusError.value,
                        ),
                      ),
                      AppSpacing.space16.verticalSpace,
                      Obx(
                        () => TextInputDropdown(
                          label: 'Status',
                          data: MenuItemStatus.values.map((e) => SelectedListItem(data: e.name)).toList(),
                          controller: controller.statusController,
                          errorText: controller.statusError.value,
                        ),
                      ),

                      AppSpacing.space32.verticalSpace,
                      AppElevatedButton(
                        onPressed: controller.onSubmit,
                        title: "Submit",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
