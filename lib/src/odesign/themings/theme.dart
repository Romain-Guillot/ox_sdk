import 'package:flutter/material.dart';
import 'package:ox_sdk/src/odesign/grid.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';

final themeExt = ThemeDataExtension(
  maxPageWidth: double.maxFinite,
  mobileScreenMax: 1024,

  mediumBorderRadius: BorderRadius.circular(20),
  smallBorderRadius: BorderRadius.circular(12),
  bigBorderRadius: BorderRadius.circular(30),
  tinyBorderRadius: BorderRadius.circular(6),
  

  padding: 18,
  paddingBig: 30,
  paddingSmall: 7, 
  pageMargin: const EdgeInsets.all(18),
  smallComponentPadding: 9,
  mediumComponentPadding: 24,
  
  backgroundVariant: Colors.black,
  barrierColor: Colors.white,

  errorColor: Colors.red,
  onErrorColor: Colors.white,
  successColor: Colors.green,
  onSuccessColor: Colors.white,
  warningColor: Colors.orange,
  onWarningColor: Colors.white,
  infoColor: Colors.blue,
  onInfoColor: Colors.white,

  tooltipTheme: const OTooltipThemeData(
    backgroundColor: Colors.black,
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal
    )
  ),

  dataGridTheme: ODataGridTheme(
    headerStyle: const OGridHeaderStyle(
      verticalSpacing: 15,
      decoration: BoxDecoration(

      ),
      textStyle: TextStyle(
        // fontSize: 15,
        color: const Color.fromARGB(255, 133, 133, 133),
        fontWeight: FontWeight.bold
      )
    ),
    rowStyle: GridRowStyle(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 18
      ),
      minHeight: 45,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!))
      )
    )
  ),
);


final theme = ThemeData(
  primaryColor: Colors.black,
  
  scaffoldBackgroundColor: const Color(0xFFF2F2F2),
  backgroundColor: const Color(0xFFF2F2F2),
  navigationRailTheme: const NavigationRailThemeData(
    unselectedLabelTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    selectedLabelTextStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    unselectedIconTheme: IconThemeData(color: Colors.black),
    selectedIconTheme: IconThemeData(color: Colors.black),
    indicatorColor: Color(0xFFD9D9D9)
    
  ),

  primarySwatch: const MaterialColor(0xff000000, {
    50: Color(0xffE0E0E0),
    100: Color(0xffB3B3B3),
    200: Color(0xff808080),
    300: Color(0xff4D4D4D),
    400: Color(0xff262626),
    500: Color(0xff000000),
    600: Color(0xff000000),
    700: Color(0xff000000),
    800: Color(0xff000000),
    900: Color(0xff000000)
  }),

  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    backgroundColor: const Color(0xFFF2F2F2),
  ),

  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: const Color(0xFFF2F2F2),
    indicatorColor: Colors.black,
    iconTheme: MaterialStateProperty.resolveWith((states) {
      return IconThemeData(
        color: states.contains(MaterialState.selected) ? const Color(0xFFF2F2F2) : Colors.black
      );
    }),
  ),
  tabBarTheme: TabBarTheme(
    // indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12),),
    labelColor: Colors.white,
    unselectedLabelColor: Colors.black,
    
  ),
   

  inputDecorationTheme: const InputDecorationTheme(
    border: UnderlineInputBorder(
      borderSide: BorderSide.none
    ),
    hintStyle: TextStyle(
      fontSize: 14,
      color: Colors.grey,
      fontWeight: FontWeight.normal
    ),
    labelStyle: TextStyle(
      fontSize: 14,
      color: Color.fromARGB(255, 114, 114, 114),
      fontWeight: FontWeight.bold,
      letterSpacing: 1.15
    )
  ),

  useMaterial3: true,
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.bold
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w900
    ),
    labelLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold
    )
  ),
  colorScheme: const ColorScheme(
    primary: Colors.black,
    onPrimary: Colors.white,

    secondary: Colors.black,
    onSecondary: Colors.white,

    background: Color(0xFFF2F2F2),
    onBackground: Colors.black,

    error: Colors.red,
    onError: Colors.white,

    surface: Colors.white,
    onSurface: Colors.black,

    brightness: Brightness.light,
  )
);