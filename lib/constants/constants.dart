library app_const;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ###################### STYLE #########################
// App Colors
const Color kDark = Color(0xff555B6E);
const Color kLightGreen = Color(0xffBEE3DB);
const Color kDarkGreen = Color(0xff89B0AE);
const Color kWhite = Color(0xffFAF9F9);
const Color kRed = Colors.red;

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

const _kStyleBodyDark = TextStyle(
    fontSize: 16,
    fontFamily: 'Tajawal',
    fontWeight: FontWeight.normal,
    color: kDark);

const _kStyleBodyWhite = TextStyle(
  fontSize: 16,
  fontFamily: 'Tajawal',
  fontWeight: FontWeight.bold,
  color: kWhite,
);

const _kStyleError = TextStyle(
  fontSize: 14,
  fontFamily: 'Tajawal',
  fontWeight: FontWeight.w300,
  color: kRed,
);

TextStyle kStyleTitle = GoogleFonts.tajawal(textStyle: _kStyleTitle);
TextStyle kStyleSecondary = GoogleFonts.tajawal(textStyle: _kStyleSecondary);
TextStyle kStyleBody = GoogleFonts.tajawal(textStyle: _kStyleBody);
TextStyle kStyleBodyDark = GoogleFonts.tajawal(textStyle: _kStyleBodyDark);
TextStyle kStyleBodyWhite = GoogleFonts.tajawal(textStyle: _kStyleBodyWhite);
TextStyle kStyleError = GoogleFonts.tajawal(textStyle: _kStyleError);

// ######################## TEXT #####################
// URLs
Image kAppLogo = Image.network(
    'https://tech-code.net/wp-content/uploads/2020/03/cropped-tech-code-logo.png');
String whatsappWebURL = "https://web.whatsapp.com/";
String techcodeWhatsappURL = "https://tech-code.net/rasil";
String whatsappExcelTemplate =
    "https://docs.google.com/spreadsheets/d/e/2PACX-1vT-tdV6M9lL_AvAjkkYsGXhFYczVjl4dnJoPccQHM1wStIJZEZHDLfpDt-aOL-eF1ecEpS-XECsf0Tn/pub?output=xlsx";
String rasilWhatsappYoutubeTutorial = "https://youtube.com";

// Regular Expressions
final mobileNumbersRE = RegExp("^(([0-9]+(-[0-9]+)?(,|\$))+)\$");
final correctSecondIntervalsRE = RegExp("[0-9]");
final paramtersRE = RegExp("(?<={).+?(?=})");

// Shared Preferences Keys
String intervalTimeKey = "intervalSP";
String licenceKey = "licenceSP";
String favMessagesLey = "favMessageSP";

// Sizes
const double elementsGap = 10;
const double borderRadius = 20;
const int saudiMobileLength = 12;

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

// ############### WIDGETS CONTANTS ##########
final OutlineInputBorder kNormalOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(
      color: kLightGreen,
      width: 2.0,
    ));

final OutlineInputBorder kErrorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(20.0),
  borderSide: const BorderSide(
    color: Colors.red,
    width: 1.0,
  ),
);
