// ignore: must_be_immutable
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/controller/doctor_address_controller.dart';
import 'package:daroon_doctor/app/modules/doctor/doctor_address/model/doctor_office_address_model.dart';
import 'package:daroon_doctor/generated/assets.dart';
import 'package:daroon_doctor/global/constants/app_colors.dart';
import 'package:daroon_doctor/global/constants/size_config.dart';
import 'package:daroon_doctor/global/utils/app_text_style.dart';
import 'package:daroon_doctor/global/utils/widget_spacing.dart';
import 'package:daroon_doctor/global/widgets/custom_cupertino_button.dart';
import 'package:daroon_doctor/global/widgets/custom_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddressContainer extends StatefulWidget {
  final OfficeAddreesModel officeAddreesModel;
  const AddressContainer({
    super.key,
    required this.officeAddreesModel,
  });

  @override
  State<AddressContainer> createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(
          vertical: 2 * SizeConfig.heightMultiplier,
          horizontal: 5 * SizeConfig.widthMultiplier),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:
              Border.all(color: AppColors.secondaryborderColor, width: 0.5)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff6FCF84)),
              ),
              10.horizontalSpace,
              Text(
                "${widget.officeAddreesModel.daysOpen.length} days per week",
                style: AppTextStyles.medium.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff898A8D),
                  fontSize: 1.4 * SizeConfig.heightMultiplier,
                ),
              ),
              const Spacer(),
              _buildMenu(context),
            ],
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Container(
            height: 0.5,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffE8E8E8),
                width: .5,
              ),
            ),
          ),
          SizedBox(height: 2 * SizeConfig.heightMultiplier),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 40,
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        Assets.locationIcon,
                        colorFilter: const ColorFilter.mode(
                            AppColors.whiteBGColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 2 * SizeConfig.heightMultiplier),
              Flexible(
                child: Column(
                  children: [
                    Text(
                      widget.officeAddreesModel.description!,
                      maxLines: 2,
                      style: AppTextStyles.black.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackBGColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  CustomPopupMenuController customPopupMenuController =
      CustomPopupMenuController();

  _buildMenu(
    BuildContext context,
  ) {
    return CustomPopupMenu(
      arrowColor: Colors.white,
      position: PreferredPosition.bottom,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Get.find<DoctorAddressController>()
                  .menuList
                  .map(
                    (item) => CustomCupertinoButton(
                      onTap: () {
                        setState(() {
                          customPopupMenuController.hideMenu();
                        });

                        if (item == "Delete") {
                          Get.dialog(
                            CustomDialogBox(
                              title: 'Delete Office Adreess',
                              iconPath: Assets.deleteIcon,
                              onPressedConfirm: () {
                                Get.back();
                                Get.find<DoctorAddressController>()
                                    .deleteOffice(
                                        data: widget.officeAddreesModel,
                                        context: context,
                                        isMainPage: true);
                              },
                              confirmButtonColor: const Color(0xffEC1C24),
                              subTitle:
                                  'Are you sure you want to\ndelete ${widget.officeAddreesModel.title} ?',
                            ),
                            barrierColor:
                                AppColors.blackBGColor.withOpacity(0.5),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    item,
                                    style: AppTextStyles.medium.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xffEC1C24)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      controller: customPopupMenuController,
      child: Container(
        height: 22,
        width: 22,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(Assets.moreDotIcon),
      ),
    );
  }
}
