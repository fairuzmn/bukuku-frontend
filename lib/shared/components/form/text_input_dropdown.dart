import 'package:bukuku_frontend/core/constant/sizing_constant.dart';
import 'package:bukuku_frontend/shared/components/form/text_input.dart';
import 'package:bukuku_frontend/shared/theme/app_typography.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInputDropdown<T> extends StatelessWidget {
  const TextInputDropdown({
    super.key,
    required this.label,
    required this.data,
    required this.controller,
    this.errorText,
  });

  final String label;
  final List<SelectedListItem<T>> data;
  final TextEditingController controller;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DropDownState(
          dropDown: DropDown(
            data: data,
            bottomSheetTitle: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.space8),
              child: Text(
                "Chose $label",
                style: AppTypography.headline3,
              ),
            ),
            listItemBuilder: (index, item) {
              return Text(
                GetUtils.capitalize(item.data.toString()) ?? "",
                style: AppTypography.paragraph3.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              );
            },
            onSelected: (selectedItems) {
              controller.text = selectedItems.first.data.toString();
            },
          ),
        ).showModal(context);
      },
      child: AppTextInput(
        hint: label,
        controller: controller,
        errorText: errorText,
        enabled: false,
      ),
    );
  }
}
