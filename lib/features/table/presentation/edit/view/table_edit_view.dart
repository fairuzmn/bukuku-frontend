import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/features/table/domain/entity/table_entity.dart';
import 'package:bukuku_frontend/features/table/presentation/edit/controller/table_edit_controller.dart';
import 'package:bukuku_frontend/shared/components/buttons/elevated_button.dart';
import 'package:bukuku_frontend/shared/components/form/text_input.dart';
import 'package:bukuku_frontend/shared/components/form/text_input_dropdown.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TableEditView extends GetView<TableEditController> {
  const TableEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 1.sh,
          width: 1.sw,
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
                    "Edit Table",
                    style: AppTypography.headline3.copyWith(),
                  ),
                ],
              ),
              Padding(
                padding: AppInsets.mainContent,
                child: Column(
                  children: [
                    AppSpacing.space32.verticalSpace,
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
                      () => TextInputDropdown(
                        label: 'Status',
                        data: TableStatus.values.map((e) => SelectedListItem(data: e.name)).toList(),
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
    );
  }
}
