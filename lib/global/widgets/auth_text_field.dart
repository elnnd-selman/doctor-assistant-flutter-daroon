import 'package:flutter/material.dart';
import 'package:hezr/global/constants/app_colors.dart';
import 'package:hezr/global/utils/app_text_style.dart';

// ignore: must_be_immutable
class CommonTextfeild extends StatefulWidget {
  CommonTextfeild({
    Key? key,
    required this.obscuretext,
    required this.hinttext,
    required this.validations,
    required this.controller,
    required this.keyboardType,
    required this.showicon,
    required this.scanIcons,
    this.onChange,
  }) : super(key: key);
  bool obscuretext;
  final String hinttext;
  final TextEditingController controller;
  final bool showicon;
  final bool scanIcons;

  Function(String)? onChange;
  // ignore: prefer_typing_uninitialized_variables
  final validations;

  // ignore: prefer_typing_uninitialized_variables
  var keyboardType;
  @override
  State<CommonTextfeild> createState() => _CommonTextfeildState();
}

class _CommonTextfeildState extends State<CommonTextfeild> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppTextStyles.medium.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: AppColors.blackBGColor,
      ),
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      cursorColor: Colors.black12,
      validator: widget.validations,
      cursorWidth: 1,
      obscureText: widget.obscuretext,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        fillColor: const Color(0xffF7F7F8),
        filled: true,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(15),
        ),
        isDense: true,
        suffixIcon: widget.showicon
            ? IconButton(
                icon: widget.obscuretext
                    ? const Icon(
                        Icons.visibility,
                        color: Colors.black45,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Colors.black45,
                      ),
                onPressed: () {
                  setState(() {
                    widget.obscuretext = !widget.obscuretext;
                  });
                },
              )
            : null,
        hintText: widget.hinttext,
        hintStyle: AppTextStyles.medium.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: const Color(0xffA0A1AB),
        ),
      ),
    );
  }
}
