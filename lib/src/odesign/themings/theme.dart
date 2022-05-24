import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ox_sdk/src/odesign/grid.dart';
import 'package:ox_sdk/src/odesign/themings/supporting_colors.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/adaptative_layout_builder.dart';


const double kBreakpointLarge = 1024;
const double kFABMarginBottom = 64;

class ThemeBuilder extends StatelessWidget {
  const ThemeBuilder({
    Key? key,
    required this.builder
  }) : super(key: key);

  final Widget Function(LayoutDensity density) builder;

  @override
  Widget build(BuildContext context) {
    return AdaptativeLayoutBuilder(
      breakpoint: kBreakpointLarge,
      narrow: builder(LayoutDensity.narrow), 
      wide: builder(LayoutDensity.wide),
    );
  }
}


enum LayoutDensity {
  narrow,
  wide
}


ThemeData theme(LayoutDensity density) {
  TextTheme textThemeFontSizes;
  switch (density) {
    case LayoutDensity.narrow:
      textThemeFontSizes = const TextTheme(
        displaySmall: TextStyle(
          fontSize: 25
        ),
        displayMedium: TextStyle(
          fontSize: 38
        ),
        titleMedium: TextStyle(
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
        ),
        labelLarge: TextStyle(
          fontSize: 15,
        )
      );
      break;
    case LayoutDensity.wide:
      textThemeFontSizes = const TextTheme(
        displaySmall: TextStyle(
          fontSize: 27
        ),
        displayMedium: TextStyle(
          fontSize: 45
        ),
        titleMedium: TextStyle(
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
        ),
        headlineSmall: TextStyle(
          fontSize: 20,
        ),
        labelLarge: TextStyle(
          fontSize: 15,
        )
      );
      break;
  }
  final radiuses = RadiusesTheme(
    tiny: BorderRadius.circular(6), 
    small: BorderRadius.circular(12), 
    medium: BorderRadius.circular(20), 
    big: BorderRadius.circular(30)
  );
  const colors = ColorsTheme(
    error: Colors.red,
    onError: Colors.white,
    success: Colors.green,
    onSuccess: Colors.white,
    warning: Colors.orange,
    onWarning: Colors.white,
    info: Colors.blue,
    onInfo: Colors.white,
    supportings: {
    SupportingColors.blue: SupportingColorData(
        primary: Color(0xFF6788FF),
        onPrimary: Colors.white,
        variant: Color(0xFF182D86),
        onVariant: Colors.white,
        container: Color(0xFFEAEEFF),
        onContainer: Colors.black
      ),
    SupportingColors.green: SupportingColorData(
        primary: Color(0xFF2DD470),
        onPrimary: Colors.white,
        variant: Color(0xFF107A3B),
        onVariant: Colors.white,
        container: Color(0xFFD6F4E2),
        onContainer: Colors.black
      ),
    SupportingColors.indigo: SupportingColorData(
        primary: Color(0xFF8044FF),
        onPrimary: Colors.white,
        variant: Color(0xFF260F81),
        onVariant: Colors.white,
        container: Color(0xFFEBEBFF),
        onContainer: Colors.black
      ),
      SupportingColors.orange: SupportingColorData(
        primary: Color(0xFFFF9567),
        onPrimary: Colors.white,
        variant: Color(0xFF883613),
        onVariant: Colors.white,
        container: Color(0xFFFCEEEA),
        onContainer: Colors.black
      ),
    SupportingColors.pink: SupportingColorData(
        primary: Color(0xFFFF67B0),
        onPrimary: Colors.white,
        variant: Color(0xFF86154B),
        onVariant: Colors.white,
        container: Color(0xFFFFEBF2),
        onContainer: Colors.black
      ),
    SupportingColors.purple: SupportingColorData(
        primary: Color(0xFFBB67FF),
        onPrimary: Colors.white,
        variant: Color(0xFF531586),
        onVariant: Colors.white,
        container: Color(0xFFF6EBFF),
        onContainer: Colors.black
      ),
    SupportingColors.red: SupportingColorData(
        primary: Color(0xFFFF6767),
        onPrimary: Colors.white,
        variant: Color(0xFF861515),
        onVariant: Colors.white,
        container: Color(0xFFFFEBEB),
        onContainer: Colors.black
      ),
    SupportingColors.yellow: SupportingColorData(
        primary: const Color(0xFFE1DB51),
        onPrimary: Colors.white,
        variant: Color(0xFF75710A),
        onVariant: Colors.white,
        container: Color(0xFFFAF9DF),
        onContainer: Colors.black
      ),
    SupportingColors.turqoise: SupportingColorData(
        primary: Color(0xFF51D9E1),
        onPrimary: Colors.white,
        variant: Color(0xFF0A6E75),
        onVariant: Colors.white,
        container: Color(0xFFDFF6F9),
        onContainer: Colors.black
      ),
    SupportingColors.eucalyptus: SupportingColorData(
        primary: Color(0xFF51E1B6),
        onPrimary: Colors.white,
        variant: Color(0xFF0A755B),
        onVariant: Colors.white,
        container: Color(0xFFDFF9F1),
        onContainer: Colors.black
      )
    }
  );
  return ThemeData(
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
        borderRadius: radiuses.medium
      ),
      backgroundColor: const Color(0xFFF2F2F2),
    ),

    appBarTheme: const AppBarTheme(
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFFF2F2F2),
        systemNavigationBarIconBrightness: Brightness.dark,
      )
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
      indicator: BoxDecoration(color: Colors.black, borderRadius: radiuses.small,),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.black,
      
    ),
    
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: radiuses.medium
      )
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

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: radiuses.small
        )
      )
    ),

    useMaterial3: true,
    
    textTheme: textThemeFontSizes.copyWith(
      displaySmall: textThemeFontSizes.displaySmall?.copyWith(
        fontWeight: FontWeight.bold
      ),
      displayMedium: textThemeFontSizes.displayMedium?.copyWith(
        fontWeight: FontWeight.bold
      ),
      titleMedium: textThemeFontSizes.titleMedium?.copyWith(
        fontWeight: FontWeight.w900
      ),
      bodyMedium: textThemeFontSizes.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold
      ),
      headlineSmall: textThemeFontSizes.headlineSmall?.copyWith(
        fontWeight: FontWeight.w900
      ),
      labelLarge: textThemeFontSizes.labelLarge?.copyWith(
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
    ),
    extensions: [
      ButtonThemes(
        error: TextButton.styleFrom(
          primary: colors.onError,
          backgroundColor: colors.error
        ),
        success: TextButton.styleFrom(
          primary: colors.onSuccess,
          backgroundColor: colors.success
        ),
      ),
      colors,
      radiuses,
      const PaddingsTheme(
        medium: 20, 
        big: 30, 
        small: 8
      ),
      const ConstraintsTheme(
        maxPageWidth: 1024,
        mobileScreenMax: kBreakpointLarge,
        snackbarMaxSize: 800
      ),
      ComponentsTheme(
        tooltip: const OTooltipThemeData(
          backgroundColor: Colors.black,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal
          )
        ),
        dataGrid: ODataGridTheme(
          headerStyle: const OGridHeaderStyle(
            verticalSpacing: 15,
            decoration: BoxDecoration(

            ),
            textStyle: TextStyle(
              // fontSize: 15,
              color: Color.fromARGB(255, 133, 133, 133),
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
      ),
      const MarginTheme(
        normal: 18
      )
    ]
  );
}

  