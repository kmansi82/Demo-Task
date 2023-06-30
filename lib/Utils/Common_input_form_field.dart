import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CommonInputFormField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  final String? placeholderImage;
  final double? placeholderImageHeight;
  final double? placeholderImageWidth;
  final double? placeholderImageHorizontalPadding;
  final String? placeholderText;
  final TextStyle? placeholderTextStyle;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final double? fieldWidth;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? fieldTextStyle;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextCapitalization? textCapitalization;
  final bool? isEnable;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final InputDecoration? inputDecoration;
  final bool? obscureText;
  final double? bottomFieldMargin;
  final Function(dynamic text)? onChanged;
  final Widget? suffixLabel;
  final Color? cursorColor;
  final bool? enableInteractiveSelection;
  final bool? readOnly;
  final Function(dynamic text)? onSubmitted;
  final EdgeInsets? scrollPadding;


  const CommonInputFormField(
      {Key? key,
        required this.textEditingController,
        required this.validator,
        this.placeholderImage,
        this.placeholderImageHeight,
        this.placeholderImageWidth,
        this.placeholderImageHorizontalPadding,
        this.placeholderText,
        this.placeholderTextStyle,
        this.hintText,
        this.hintTextStyle,
        this.fieldWidth,
        this.backgroundColor,
        this.borderColor,
        this.borderWidth,
        this.borderRadius,
        this.fieldTextStyle,
        this.maxLines,
        this.maxLength,
        this.textInputFormatter,
        this.textInputAction,
        this.textInputType,
        this.textCapitalization,
        this.isEnable,
        this.prefixWidget,
        this.suffixWidget,
        this.inputDecoration,
        this.obscureText,
        this.bottomFieldMargin,
        this.onChanged,
        this.suffixLabel,
        this.cursorColor,
        this.enableInteractiveSelection,
        this.readOnly,
        this.onSubmitted,
        this.scrollPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (((placeholderImage ?? '').isNotEmpty) ||
            ((placeholderText ?? '').isNotEmpty))
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if ((placeholderImage ?? '').isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(
                        right: placeholderImageHorizontalPadding ?? 0.w),
                    child: Image.asset(
                      placeholderImage!,
                      height: placeholderImageHeight ?? 32,
                      width: placeholderImageWidth ?? 32,
                    ),
                  ),
                if ((placeholderText ?? '').isNotEmpty)
                  Text(
                    placeholderText!,
                    style: placeholderTextStyle ??
                        TextStyle(color: Colors.black, fontSize: 14.sp),
                  ),
                if (suffixLabel != null) suffixLabel!
              ],
            ),
          ),
        SizedBox(
          width: fieldWidth ?? double.infinity,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomFieldMargin ?? 20),
            child: TextFormField(
              scrollPadding: scrollPadding?? EdgeInsets.zero,
              readOnly: readOnly ?? false,
              cursorColor: Colors.black,
              controller: textEditingController,
              style: TextStyle(color: Colors.black, fontSize: 14.sp),
              textAlign: TextAlign.start,
              textAlignVertical: TextAlignVertical.center,
              maxLines: maxLines ?? 1,
              maxLength: maxLength ?? 1000,
              enableInteractiveSelection: enableInteractiveSelection ?? true,
              obscureText: obscureText ?? false,
              inputFormatters: textInputFormatter,
              onChanged: onChanged,
              textInputAction: textInputAction ?? TextInputAction.next,
              keyboardType: textInputType ?? TextInputType.text,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              decoration: InputDecoration(
                  errorMaxLines: 3,
                  enabled: isEnable ?? true,
                  counterText: '',
                  filled: true,
                  fillColor: Colors.transparent,
                  suffixIcon: suffixWidget != null
                      ? Padding(
                      padding: const EdgeInsets.all(0), child: suffixWidget)
                      : null,
                  prefixIcon: prefixWidget,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: borderWidth ?? 1,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: borderRadius ?? BorderRadius.circular(10.r),
                  ),
                  border: InputBorder.none,
                  hintText: hintText,
                  alignLabelWithHint: true,
                  hintStyle: hintTextStyle),
              onFieldSubmitted: onSubmitted ??(text) {
                textEditingController?.text = text;
              },
              validator: validator,
            ),
          ),
        )
      ],
    );
  }
}
/*
Widget Usage

CommonInputFormField(
  textEditingController: _mobileController,
  suffixWidget: Image.asset(Assets.imagesIcApple),
  validator: validateEmail,
  backgroundColor: AppColors.pinch,
  prefixWidget: Image.asset(Assets.imagesIcApple),
  placeholderImage: Assets.imagesIcApple,
  placeholderText: 'Mobile Number',
)
*/
