// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:realdating/widgets/size_utils.dart';
//
// import '../../../reel/common_import.dart';
//
// // ignore_for_file: must_be_immutable
// class BusinessProfileScreen extends StatelessWidget {
//   BusinessProfileScreen({Key? key}) : super(key: key);
//
//   TextEditingController businessNameController = TextEditingController();
//
//   TextEditingController editTextController = TextEditingController();
//
//   TextEditingController mobileNoController = TextEditingController();
//
//   TextEditingController categoryCounterController = TextEditingController();
//
//   TextEditingController weburlController = TextEditingController();
//
//   TextEditingController twitterWeburlController = TextEditingController();
//
//   TextEditingController websiteValueController = TextEditingController();
//
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: Form(
//                 key: _formKey,
//                 child: SizedBox(
//                     width: double.maxFinite,
//                     child: Column(children: [
//                       // _buildAppBar(context),
//                       SizedBox(height: 50.v),
//                       Expanded(
//                           child: SingleChildScrollView(
//                               child: Container(
//                                   margin: EdgeInsets.only(bottom: 5.v),
//                                   padding:
//                                   EdgeInsets.symmetric(horizontal: 20.h),
//                                   child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text("Business Name", style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 8.v),
//                                         _buildBusinessName(context),
//                                         SizedBox(height: 17.v),
//                                         Text("Business Hours",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 8.v),
//                                         _buildEmailInput(context),
//                                         SizedBox(height: 17.v),
//                                         Text("Description",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 4.v),
//                                         _buildEditText(context),
//                                         SizedBox(height: 18.v),
//                                         Text("Number",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 8.v),
//                                         _buildMobileNo(context),
//                                         SizedBox(height: 18.v),
//                                         Text("Category",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 4.v),
//                                         _buildCategoryCounter(context),
//                                         SizedBox(height: 18.v),
//                                         Text("Instagram",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 4.v),
//                                         _buildWeburl(context),
//                                         SizedBox(height: 18.v),
//                                         Text("Facebook",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 8.v),
//                                         _buildTwitterWeburl(context),
//                                         SizedBox(height: 17.v),
//                                         _buildSaveButton(context),
//                                         Text("Website",
//                                             style: theme.textTheme.titleMedium),
//                                         SizedBox(height: 8.v),
//                                         _buildWebsiteValue(context)
//                                       ]))))
//                     ])))));
//   }
//
//   /// Section Widget
//   // Widget _buildAppBar(BuildContext context) {
//   //   return SizedBox(
//   //       height: 274.v,
//   //       width: double.maxFinite,
//   //       child: Stack(alignment: Alignment.bottomCenter, children: [
//   //         Align(
//   //             alignment: Alignment.topCenter,
//   //             child: Container(
//   //                 padding: EdgeInsets.symmetric(vertical: 34.v),
//   //                 decoration: BoxDecoration(
//   //                     image: DecorationImage(
//   //                         image: fs.Svg(ImageConstant.imgGroup2),
//   //                         fit: BoxFit.cover)),
//   //                 child: Column(mainAxisSize: MainAxisSize.min, children: [
//   //                   CustomAppBar(
//   //                       leadingWidth: 72.h,
//   //                       leading: AppbarLeadingIconbutton(
//   //                           imagePath: ImageConstant.imgArrowLeft,
//   //                           margin: EdgeInsets.only(left: 20.h, bottom: 8.v),
//   //                           onTap: () {
//   //                             onTapArrowLeft(context);
//   //                           }),
//   //                       centerTitle: true,
//   //                       title: AppbarTitleImage(
//   //                           imagePath: ImageConstant.imgInbox,
//   //                           margin: EdgeInsets.only(top: 30.v))),
//   //                   SizedBox(height: 9.v),
//   //                   Text("Add Cover Photo", style: theme.textTheme.titleSmall),
//   //                   SizedBox(height: 55.v),
//   //                   CustomImageView(
//   //                       imagePath: ImageConstant.imgEditContained,
//   //                       height: 16.adaptSize,
//   //                       width: 16.adaptSize,
//   //                       alignment: Alignment.centerRight,
//   //                       margin: EdgeInsets.only(right: 24.h)),
//   //                   SizedBox(height: 8.v)
//   //                 ]))),
//   //         Align(
//   //             alignment: Alignment.bottomCenter,
//   //             child: Container(
//   //                 height: 100.adaptSize,
//   //                 width: 100.adaptSize,
//   //                 margin: EdgeInsets.only(bottom: 6.v),
//   //                 padding: EdgeInsets.all(35.h),
//   //                 decoration: AppDecoration.outlinePrimary
//   //                     .copyWith(borderRadius: BorderRadiusStyle.circleBorder50),
//   //                 child: CustomImageView(
//   //                     imagePath: ImageConstant.imgInbox,
//   //                     height: 30.adaptSize,
//   //                     width: 30.adaptSize,
//   //                     alignment: Alignment.center))),
//   //         CustomImageView(
//   //             imagePath: ImageConstant.imgSuccess11,
//   //             height: 36.adaptSize,
//   //             width: 36.adaptSize,
//   //             alignment: Alignment.bottomRight,
//   //             margin: EdgeInsets.only(right: 146.h))
//   //       ]));
//   // }
//
//   /// Section Widget
//   Widget _buildBusinessName(BuildContext context ) {
//     return CustomTextFormField(
//         controller: businessNameController,
//         hintText: "Fauget",
//         hintStyle: CustomTextStyles.titleMediumErrorContainer,
//         contentPadding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 15.v),
//         borderDecoration: TextFormFieldStyleHelper.outlineBlueGray,
//         filled: false);
//   }
//
//   /// Section Widget
//   Widget _buildEmailInput(BuildContext context) {
//     return Container(
//         padding: EdgeInsets.all(14.h),
//         decoration: AppDecoration.outlineBlueGray
//             .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
//         child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           CustomImageView(
//               imagePath: "",
//               height: 16.adaptSize,
//               width: 16.adaptSize,
//               margin: EdgeInsets.only(bottom: 2.v)),
//           Padding(
//               padding: EdgeInsets.only(left: 12.h, bottom: 1.v),
//               child: Text("Schedule hours",
//                   style: CustomTextStyles.titleMediumErrorContainer)),
//           Spacer(),
//           CustomImageView(
//               imagePath: "",
//               height: 10.v,
//               width: 5.h,
//               margin: EdgeInsets.only(top: 4.v, bottom: 2.v))
//         ]));
//   }
//
//   /// Section Widget
//   Widget _buildEditText(BuildContext context) {
//     return CustomTextFormField(controller: editTextController);
//   }
//
//   /// Section Widget
//   Widget _buildMobileNo(BuildContext context) {
//     return CustomTextFormField(
//         controller: mobileNoController, hintText: "+91 9876543210");
//   }
//
//   /// Section Widget
//   Widget _buildCategoryCounter(BuildContext context) {
//     return CustomTextFormField(
//         controller: categoryCounterController, hintText: "Category 1");
//   }
//
//   /// Section Widget
//   Widget _buildWeburl(BuildContext context) {
//     return CustomTextFormField(
//         controller: weburlController,
//         hintText: "https://instagram.com/username");
//   }
//
//   /// Section Widget
//   Widget _buildTwitterWeburl(BuildContext context) {
//     return CustomTextFormField(
//         controller: twitterWeburlController,
//         hintText: "https://facebook.com/username");
//   }
//
//   /// Section Widget
//   Widget _buildSaveButton(BuildContext context) {
//     return SizedBox(
//         height: 93.v,
//         width: 350.h,
//         child: Stack(alignment: Alignment.bottomCenter, children: [
//           Align(
//               alignment: Alignment.topCenter,
//               child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Twitter", style: theme.textTheme.titleMedium),
//                     SizedBox(height: 8.v),
//                     Container(
//                         width: 350.h,
//                         padding: EdgeInsets.symmetric(vertical: 13.v),
//                         decoration: AppDecoration.outlineBluegray100.copyWith(
//                             borderRadius: BorderRadiusStyle.roundedBorder5),
//                         child: Opacity(
//                             opacity: 0.5,
//                             child: GestureDetector(
//                                 onTap: () {
//                                   onTapTxtWeburl(context);
//                                 },
//                                 child: Text("https://twitter.com/username",
//                                     style: theme.textTheme.bodyMedium))))
//                   ])),
//           CustomOutlinedButton(
//               width: 350.h,
//               text: "save",
//               buttonStyle: CustomButtonStyles.none,
//               decoration: CustomButtonStyles.gradientOnErrorToPrimaryDecoration,
//               alignment: Alignment.bottomCenter)
//         ]));
//   }
//
//   /// Section Widget
//   Widget _buildWebsiteValue(BuildContext context) {
//     return CustomTextFormField(
//         controller: websiteValueController,
//         hintText: "https://wwww.mywebsite.com",
//         textInputAction: TextInputAction.done);
//   }
//
//   /// Navigates back to the previous screen.
//   onTapArrowLeft(BuildContext context) {
//     Navigator.pop(context);
//   }
//
//   onTapTxtWeburl(BuildContext context) {
//     // TODO: implement Actions
//   }
// }
//
//
//
//
//
//
//
//
//
// class CustomTextFormField extends StatelessWidget {
//   CustomTextFormField({
//     Key? key,
//     this.alignment,
//     this.width,
//     this.scrollPadding,
//     this.controller,
//     this.focusNode,
//     this.autofocus = true,
//     this.textStyle,
//     this.obscureText = false,
//     this.textInputAction = TextInputAction.next,
//     this.textInputType = TextInputType.text,
//     this.maxLines,
//     this.hintText,
//     this.hintStyle,
//     this.prefix,
//     this.prefixConstraints,
//     this.suffix,
//     this.suffixConstraints,
//     this.contentPadding,
//     this.borderDecoration,
//     this.fillColor,
//     this.filled = true,
//     this.validator,
//   }) : super(
//     key: key,
//   );
//
//   final Alignment? alignment;
//
//   final double? width;
//
//   final TextEditingController? scrollPadding;
//
//   final TextEditingController? controller;
//
//   final FocusNode? focusNode;
//
//   final bool? autofocus;
//
//   final TextStyle? textStyle;
//
//   final bool? obscureText;
//
//   final TextInputAction? textInputAction;
//
//   final TextInputType? textInputType;
//
//   final int? maxLines;
//
//   final String? hintText;
//
//   final TextStyle? hintStyle;
//
//   final Widget? prefix;
//
//   final BoxConstraints? prefixConstraints;
//
//   final Widget? suffix;
//
//   final BoxConstraints? suffixConstraints;
//
//   final EdgeInsets? contentPadding;
//
//   final InputBorder? borderDecoration;
//
//   final Color? fillColor;
//
//   final bool? filled;
//
//   final FormFieldValidator<String>? validator;
//
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//       alignment: alignment ?? Alignment.center,
//       child: textFormFieldWidget(context),
//     )
//         : textFormFieldWidget(context);
//   }
//
//   Widget textFormFieldWidget(BuildContext context) => SizedBox(
//     width: width ?? double.maxFinite,
//     child: TextFormField(
//       scrollPadding:
//       EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//       controller: controller,
//       focusNode: focusNode ?? FocusNode(),
//       autofocus: autofocus!,
//       style: textStyle ?? theme.textTheme.bodyMedium,
//       obscureText: obscureText!,
//       textInputAction: textInputAction,
//       keyboardType: textInputType,
//       maxLines: maxLines ?? 1,
//       decoration: decoration,
//       validator: validator,
//     ),
//   );
//   InputDecoration get decoration => InputDecoration(
//     hintText: hintText ?? "",
//     hintStyle: hintStyle ?? theme.textTheme.bodyMedium,
//     prefixIcon: prefix,
//     prefixIconConstraints: prefixConstraints,
//     suffixIcon: suffix,
//     suffixIconConstraints: suffixConstraints,
//     isDense: true,
//     contentPadding: contentPadding ??
//         EdgeInsets.symmetric(
//           horizontal: 2.h,
//           vertical: 17.v,
//         ),
//     fillColor: fillColor ?? theme.colorScheme.primaryContainer,
//     filled: filled,
//     border: borderDecoration ??
//         OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5.h),
//           borderSide: BorderSide(
//             color: appTheme.blueGray100,
//             width: 1,
//           ),
//         ),
//     enabledBorder: borderDecoration ??
//         OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5.h),
//           borderSide: BorderSide(
//             color: appTheme.blueGray100,
//             width: 1,
//           ),
//         ),
//     focusedBorder: borderDecoration ??
//         OutlineInputBorder(
//           borderRadius: BorderRadius.circular(5.h),
//           borderSide: BorderSide(
//             color: appTheme.blueGray100,
//             width: 1,
//           ),
//         ),
//   );
// }
//
// /// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
// extension TextFormFieldStyleHelper on CustomTextFormField {
//   static OutlineInputBorder get outlineBlueGray => OutlineInputBorder(
//     borderRadius: BorderRadius.circular(5.h),
//     borderSide: BorderSide(
//       color: appTheme.blueGray100,
//       width: 1,
//     ),
//   );
// }
//
//
// class CustomOutlinedButton extends BaseButton {
//   CustomOutlinedButton({
//     Key? key,
//     this.decoration,
//     this.leftIcon,
//     this.rightIcon,
//     this.label,
//     VoidCallback? onPressed,
//     ButtonStyle? buttonStyle,
//     TextStyle? buttonTextStyle,
//     bool? isDisabled,
//     Alignment? alignment,
//     double? height,
//     double? width,
//     EdgeInsets? margin,
//     required String text,
//   }) : super(
//     text: text,
//     onPressed: onPressed,
//     buttonStyle: buttonStyle,
//     isDisabled: isDisabled,
//     buttonTextStyle: buttonTextStyle,
//     height: height,
//     alignment: alignment,
//     width: width,
//     margin: margin,
//   );
//
//   final BoxDecoration? decoration;
//
//   final Widget? leftIcon;
//
//   final Widget? rightIcon;
//
//   final Widget? label;
//
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//       alignment: alignment ?? Alignment.center,
//       child: buildOutlinedButtonWidget,
//     )
//         : buildOutlinedButtonWidget;
//   }
//
//   Widget get buildOutlinedButtonWidget => Container(
//     height: this.height ?? 56.v,
//     width: this.width ?? double.maxFinite,
//     margin: margin,
//     decoration:
//     decoration ?? CustomButtonStyles.gradientOnErrorToPrimaryDecoration,
//     child: OutlinedButton(
//       style: buttonStyle,
//       onPressed: isDisabled ?? false ? null : onPressed ?? () {},
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           leftIcon ?? const SizedBox.shrink(),
//           Text(
//             text,
//             style: buttonTextStyle ??
//                 CustomTextStyles.titleMediumPrimaryContainer,
//           ),
//           rightIcon ?? const SizedBox.shrink(),
//         ],
//       ),
//     ),
//   );
// }
//
//
//
// class CustomImageView extends StatelessWidget {
//   ///[imagePath] is required parameter for showing image
//   String? imagePath;
//
//   double? height;
//   double? width;
//   Color? color;
//   BoxFit? fit;
//   final String placeHolder;
//   Alignment? alignment;
//   VoidCallback? onTap;
//   EdgeInsetsGeometry? margin;
//   BorderRadius? radius;
//   BoxBorder? border;
//
//   ///a [CustomImageView] it can be used for showing any type of images
//   /// it will shows the placeholder image if image is not found on network image
//   CustomImageView({
//     this.imagePath,
//     this.height,
//     this.width,
//     this.color,
//     this.fit,
//     this.alignment,
//     this.onTap,
//     this.radius,
//     this.margin,
//     this.border,
//     this.placeHolder = 'assets/images/image_not_found.png',
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//       alignment: alignment!,
//       child: _buildWidget(),
//     )
//         : _buildWidget();
//   }
//
//   Widget _buildWidget() {
//     return Padding(
//       padding: margin ?? EdgeInsets.zero,
//       child: InkWell(
//         onTap: onTap,
//         child: _buildCircleImage(),
//       ),
//     );
//   }
//
//   ///build the image with border radius
//   _buildCircleImage() {
//     if (radius != null) {
//       return ClipRRect(
//         borderRadius: radius ?? BorderRadius.zero,
//         child: _buildImageWithBorder(),
//       );
//     } else {
//       return _buildImageWithBorder();
//     }
//   }
//
//   ///build the image with border and border radius style
//   _buildImageWithBorder() {
//     if (border != null) {
//       return Container(
//         decoration: BoxDecoration(
//           border: border,
//           borderRadius: radius,
//         ),
//         child: _buildImageView(),
//       );
//     } else {
//       return _buildImageView();
//     }
//   }
//
//   Widget _buildImageView() {
//     if (imagePath != null) {
//       switch (imagePath!.imageType) {
//         case ImageType.svg:
//           return Container(
//             height: height,
//             width: width,
//             child: SvgPicture.asset(
//               imagePath!,
//               height: height,
//               width: width,
//               fit: fit ?? BoxFit.contain,
//               colorFilter: ColorFilter.mode(
//                   color ?? Colors.transparent, BlendMode.srcIn),
//             ),
//           );
//         case ImageType.file:
//           return Image.file(
//             File(imagePath!),
//             height: height,
//             width: width,
//             fit: fit ?? BoxFit.cover,
//             color: color,
//           );
//         case ImageType.network:
//           return CachedNetworkImage(
//             height: height,
//             width: width,
//             fit: fit,
//             imageUrl: imagePath!,
//             color: color,
//             placeholder: (context, url) => Container(
//               height: 30,
//               width: 30,
//               child: LinearProgressIndicator(
//                 color: Colors.grey.shade200,
//                 backgroundColor: Colors.grey.shade100,
//               ),
//             ),
//             errorWidget: (context, url, error) => Image.asset(
//               placeHolder,
//               height: height,
//               width: width,
//               fit: fit ?? BoxFit.cover,
//             ),
//           );
//         case ImageType.png:
//         default:
//           return Image.asset(
//             imagePath!,
//             height: height,
//             width: width,
//             fit: fit ?? BoxFit.cover,
//             color: color,
//           );
//       }
//     }
//     return SizedBox();
//   }
// }
//
// extension ImageTypeExtension on String {
//   ImageType get imageType {
//     if (this.startsWith('http') || this.startsWith('https')) {
//       return ImageType.network;
//     } else if (this.endsWith('.svg')) {
//       return ImageType.svg;
//     } else if (this.startsWith('file://')) {
//       return ImageType.file;
//     } else {
//       return ImageType.png;
//     }
//   }
// }
//
// enum ImageType { svg, png, network, file, unknown }
//
//
//
// class CustomIconButton extends StatelessWidget {
//   CustomIconButton({
//     Key? key,
//     this.alignment,
//     this.height,
//     this.width,
//     this.padding,
//     this.decoration,
//     this.child,
//     this.onTap,
//   }) : super(
//     key: key,
//   );
//
//   final Alignment? alignment;
//
//   final double? height;
//
//   final double? width;
//
//   final EdgeInsetsGeometry? padding;
//
//   final BoxDecoration? decoration;
//
//   final Widget? child;
//
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//       alignment: alignment ?? Alignment.center,
//       child: iconButtonWidget,
//     )
//         : iconButtonWidget;
//   }
//
//   Widget get iconButtonWidget => SizedBox(
//     height: height ?? 0,
//     width: width ?? 0,
//     child: IconButton(
//       padding: EdgeInsets.zero,
//       icon: Container(
//         height: height ?? 0,
//         width: width ?? 0,
//         padding: padding ?? EdgeInsets.zero,
//         decoration: decoration ??
//             BoxDecoration(
//               color: theme.colorScheme.primaryContainer,
//               borderRadius: BorderRadius.circular(15.h),
//               border: Border.all(
//                 color: appTheme.gray20001,
//                 width: 1.h,
//               ),
//             ),
//         child: child,
//       ),
//       onPressed: onTap,
//     ),
//   );
// }
//
//
// class BaseButton extends StatelessWidget {
//   BaseButton({
//     Key? key,
//     required this.text,
//     this.onPressed,
//     this.buttonStyle,
//     this.buttonTextStyle,
//     this.isDisabled,
//     this.height,
//     this.width,
//     this.margin,
//     this.alignment,
//   }) : super(
//     key: key,
//   );
//
//   final String text;
//
//   final VoidCallback? onPressed;
//
//   final ButtonStyle? buttonStyle;
//
//   final TextStyle? buttonTextStyle;
//
//   final bool? isDisabled;
//
//   final double? height;
//
//   final double? width;
//
//   final EdgeInsets? margin;
//
//   final Alignment? alignment;
//
//   @override
//   Widget build(BuildContext context) {
//     return const SizedBox.shrink();
//   }
// }
//
//
//
// // ignore: must_be_immutable
// class AppbarLeadingIconbutton extends StatelessWidget {
//   AppbarLeadingIconbutton({
//     Key? key,
//     this.imagePath,
//     this.margin,
//     this.onTap,
//   }) : super(
//     key: key,
//   );
//
//   String? imagePath;
//
//   EdgeInsetsGeometry? margin;
//
//   Function? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap!.call();
//       },
//       child: Padding(
//         padding: margin ?? EdgeInsets.zero,
//         child: CustomIconButton(
//           height: 52.adaptSize,
//           width: 52.adaptSize,
//           child: CustomImageView(
//             imagePath: "",
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // ignore: must_be_immutable
// class AppbarTitleImage extends StatelessWidget {
//   AppbarTitleImage({
//     Key? key,
//     this.imagePath,
//     this.margin,
//     this.onTap,
//   }) : super(
//     key: key,
//   );
//
//   String? imagePath;
//
//   EdgeInsetsGeometry? margin;
//
//   Function? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onTap!.call();
//       },
//       child: Padding(
//         padding: margin ?? EdgeInsets.zero,
//         child: CustomImageView(
//           imagePath: imagePath,
//           height: 30.adaptSize,
//           width: 30.adaptSize,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }
//
//
// class CustomTextStyles {
//   // Title text style
//   static get titleMediumErrorContainer => theme.textTheme.titleMedium!.copyWith(
//     color: theme.colorScheme.errorContainer.withOpacity(1),
//     fontSize: 16.fSize,
//     fontWeight: FontWeight.w500,
//   );
//   static get titleMediumPrimaryContainer =>
//       theme.textTheme.titleMedium!.copyWith(
//         color: theme.colorScheme.primaryContainer,
//         fontSize: 17.fSize,
//       );
// }
//
// extension on TextStyle {
//   TextStyle get inter {
//     return copyWith(
//       fontFamily: 'Inter',
//     );
//   }
// }
//
//
// String _appTheme = "primary";
//
// /// Helper class for managing themes and colors.
// class ThemeHelper {
//   // A map of custom color themes supported by the app
//   Map<String, PrimaryColors> _supportedCustomColor = {
//     'primary': PrimaryColors()
//   };
//
// // A map of color schemes supported by the app
//   Map<String, ColorScheme> _supportedColorScheme = {
//     'primary': ColorSchemes.primaryColorScheme
//   };
//
//   /// Changes the app theme to [_newTheme].
//   void changeTheme(String _newTheme) {
//     _appTheme = _newTheme;
//   }
//
//   /// Returns the primary colors for the current theme.
//   PrimaryColors _getThemeColors() {
//     //throw exception to notify given theme is not found or not generated by the generator
//     if (!_supportedCustomColor.containsKey(_appTheme)) {
//       throw Exception(
//           "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
//     }
//     //return theme from map
//
//     return _supportedCustomColor[_appTheme] ?? PrimaryColors();
//   }
//
//   /// Returns the current theme data.
//   ThemeData _getThemeData() {
//     //throw exception to notify given theme is not found or not generated by the generator
//     if (!_supportedColorScheme.containsKey(_appTheme)) {
//       throw Exception(
//           "$_appTheme is not found.Make sure you have added this theme class in JSON Try running flutter pub run build_runner");
//     }
//     //return theme from map
//
//     var colorScheme =
//         _supportedColorScheme[_appTheme] ?? ColorSchemes.primaryColorScheme;
//     return ThemeData(
//       visualDensity: VisualDensity.standard,
//       colorScheme: colorScheme,
//       textTheme: TextThemes.textTheme(colorScheme),
//       scaffoldBackgroundColor: colorScheme.primaryContainer,
//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: OutlinedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           side: BorderSide(
//             color: colorScheme.primaryContainer,
//             width: 1.h,
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(28.h),
//           ),
//           visualDensity: const VisualDensity(
//             vertical: -4,
//             horizontal: -4,
//           ),
//           padding: EdgeInsets.zero,
//         ),
//       ),
//     );
//   }
//
//   /// Returns the primary colors for the current theme.
//   PrimaryColors themeColor() => _getThemeColors();
//
//   /// Returns the current theme data.
//   ThemeData themeData() => _getThemeData();
// }
//
// /// Class containing the supported text theme styles.
// class TextThemes {
//   static TextTheme textTheme(ColorScheme colorScheme) => TextTheme(
//     bodyMedium: TextStyle(
//       color: colorScheme.errorContainer,
//       fontSize: 15.fSize,
//       fontFamily: 'Inter',
//       fontWeight: FontWeight.w400,
//     ),
//     titleMedium: TextStyle(
//       color: colorScheme.onPrimary,
//       fontSize: 18.fSize,
//       fontFamily: 'Inter',
//       fontWeight: FontWeight.w600,
//     ),
//     titleSmall: TextStyle(
//       color: colorScheme.errorContainer.withOpacity(1),
//       fontSize: 15.fSize,
//       fontFamily: 'Inter',
//       fontWeight: FontWeight.w500,
//     ),
//   );
// }
//
// /// Class containing the supported color schemes.
// class ColorSchemes {
//   static final primaryColorScheme = ColorScheme.light(
//     // Primary colors
//     primary: Color(0XFFFB4967),
//     primaryContainer: Color(0XFFFFFFFF),
//
//     // Error colors
//     errorContainer: Color(0X87000000),
//     onError: Color(0XFFF65F51),
//
//     // On colors(text colors)
//     onPrimary: Color(0XFF111111),
//   );
// }
//
// /// Class containing custom colors for a primary theme.
// class PrimaryColors {
//   // BlueGray
//   Color get blueGray100 => Color(0XFFD9D9D9);
//
//   // Gray
//   Color get gray200 => Color(0XFFEDEDED);
//   Color get gray20001 => Color(0XFFE8E6EA);
//
//   // Red
//   Color get redA200 => Color(0XFFFA4B65);
// }
//
// PrimaryColors get appTheme => ThemeHelper().themeColor();
// ThemeData get theme => ThemeHelper().themeData();
//
// /// A class that offers pre-defined button styles for customizing button appearance.
// class CustomButtonStyles {
//   // Gradient button style
//   static BoxDecoration get gradientOnErrorToPrimaryDecoration => BoxDecoration(
//     borderRadius: BorderRadius.circular(28.h),
//     border: Border.all(
//       color: theme.colorScheme.primaryContainer,
//       width: 1.h,
//     ),
//     gradient: LinearGradient(
//       begin: Alignment(0.5, 0),
//       end: Alignment(0.5, 1),
//       colors: [
//         theme.colorScheme.onError,
//         theme.colorScheme.primary,
//       ],
//     ),
//   );
//   // text button style
//   static ButtonStyle get none => ButtonStyle(
//     backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
//     elevation: MaterialStateProperty.all<double>(0),
//   );
// }
//
//
// class AppDecoration {
//   // Fill decorations
//   static BoxDecoration get fillPrimaryContainer => BoxDecoration(
//     color: theme.colorScheme.primaryContainer,
//   );
//
//   // Outline decorations
//   static BoxDecoration get outlineBlueGray => BoxDecoration(
//     border: Border.all(
//       color: appTheme.blueGray100,
//       width: 1.h,
//     ),
//   );
//   static BoxDecoration get outlineBluegray100 => BoxDecoration(
//     color: theme.colorScheme.primaryContainer,
//     border: Border.all(
//       color: appTheme.blueGray100,
//       width: 1.h,
//     ),
//   );
//   static BoxDecoration get outlinePrimary => BoxDecoration(
//     border: Border.all(
//       color: theme.colorScheme.primary,
//       width: 2.h,
//       strokeAlign: strokeAlignOutside,
//     ),
//   );
// }
//
// class BorderRadiusStyle {
//   // Circle borders
//   static BorderRadius get circleBorder50 => BorderRadius.circular(
//     50.h,
//   );
//
//   // Rounded borders
//   static BorderRadius get roundedBorder5 => BorderRadius.circular(
//     5.h,
//   );
// }
//
// // Comment/Uncomment the below code based on your Flutter SDK version.
//
// // For Flutter SDK Version 3.7.2 or greater.
//
// double get strokeAlignInside => BorderSide.strokeAlignInside;
//
// double get strokeAlignCenter => BorderSide.strokeAlignCenter;
//
// double get strokeAlignOutside => BorderSide.strokeAlignOutside;
//
// // For Flutter SDK Version 3.7.1 or less.
//
// // StrokeAlign get strokeAlignInside => StrokeAlign.inside;
// //
// // StrokeAlign get strokeAlignCenter => StrokeAlign.center;
// //
// // StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
