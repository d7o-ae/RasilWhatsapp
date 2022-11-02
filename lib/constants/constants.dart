library app_const;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ###################### STYLE #########################
// App Colors
const Color kDark = Color(0xff555B6E);
const Color kLightGreen = Color(0xffBEE3DB);
const Color kDarkGreen = Color(0xff89B0AE);
const Color kWhite = Color(0xffFAF9F9);

// Text Styles
const _kStyleTitle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: kDark,
);

const _kStyleSecondary = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.normal,
  color: Colors.black,
);

const _kStyleBody = TextStyle(
  fontSize: 16,
  fontFamily: 'Tajawal',
  fontWeight: FontWeight.normal,
  color: kDarkGreen,
);

const _kStyleBodyWhite = TextStyle(
  fontSize: 16,
  fontFamily: 'Tajawal',
  fontWeight: FontWeight.bold,
  color: kWhite,
);

TextStyle kStyleTitle = GoogleFonts.tajawal(textStyle: _kStyleTitle);
TextStyle kStyleSecondary = GoogleFonts.tajawal(textStyle: _kStyleSecondary);
TextStyle kStyleBody = GoogleFonts.tajawal(textStyle: _kStyleBody);
TextStyle kStyleBodyWhite = GoogleFonts.tajawal(textStyle: _kStyleBodyWhite);

// ######################## TEXT #####################
// URLs
Image kAppLogo = Image.network(
    'https://tech-code.net/wp-content/uploads/2020/03/cropped-tech-code-logo.png');

// Regular Expressions
final mobileNumbersRE = RegExp("^(([0-9]+(-[0-9]+)?(,|\$))+)\$");

// Sizes
const double elementsGap = 10;
const double borderRadius = 20;

// Strings
const String kAppName = 'Tech-Code Projects Management System';
const String fontName = 'Tajawal';
final transactionCollection = 'transactions';
final totalsCollection = 'totals';
final categoriesCollection = 'categories';
final noCategoriesFound = "لم يتم العثور على تصنيفات";
final somethingWrong = "حصل خطأ ما";

// ############## ASSETS #############

final defaultCategoryAsset = 'assets/images/splash.png';

List<String> categoriesIcons1 = [
  "assets/icons/1.png",
  "assets/icons/2.png",
  "assets/icons/3.png",
  "assets/icons/4.png",
  "assets/icons/5.png",
];
List<String> categoriesIcons0 = [
  "assets/icons/6.png",
  "assets/icons/7.png",
  "assets/icons/8.png",
  "assets/icons/9.png",
  "assets/icons/10.png"
];
