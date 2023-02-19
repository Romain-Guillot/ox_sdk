import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ox_sdk/src/odesign/grid.dart';
import 'package:ox_sdk/src/odesign/themings/supporting_colors.dart';
import 'package:ox_sdk/src/odesign/themings/theme_extension.dart';
import 'package:ox_sdk/src/utils/components/adaptative_layout_builder.dart';


const double kBreakpointLarge = 1024;
const double kFABMarginBottom = 66;
const double kFABMargin = 64;

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


const colorScheme =  ColorScheme(
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

  primaryContainer: Colors.white,
  onPrimaryContainer: Colors.black,

  brightness: Brightness.light,
);


ThemeData theme(LayoutDensity density, {
  ColorScheme colorScheme = colorScheme
}) {
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
        titleLarge: TextStyle(
          fontSize: 24
        ),
        titleSmall: TextStyle(
          fontSize: 15,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
        ),
        bodyLarge: TextStyle(
          fontSize: 15,
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
        titleLarge: TextStyle(
          fontSize: 30
        ),
        titleSmall: TextStyle(
          fontSize: 16,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
        ),
        bodySmall: TextStyle(
          fontSize: 13,
        ),
        bodyMedium: TextStyle(
          fontSize: 13,
        ),
        bodyLarge: TextStyle(
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
    tiny: BorderRadius.circular(4), 
    small: BorderRadius.circular(10), 
    medium: BorderRadius.circular(15), 
    big: BorderRadius.circular(22)
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
        primary: Color(0xFF6B8AF6),
        onPrimary: Colors.white,
        variant: Color(0xFF374FB6),
        onVariant: Colors.white,
        container: Color(0xFF6B8AF6),
        onContainer: Colors.white
      ),
    SupportingColors.green: SupportingColorData(
        primary: Color(0xFF2DD470),
        onPrimary: Colors.white,
        variant: Color(0xFF23A356),
        onVariant: Colors.white,
        container: Color(0xFF2DD470),
        onContainer: Colors.white
      ),
    SupportingColors.indigo: SupportingColorData(
        primary: Color(0xFF8044FF),
        onPrimary: Colors.white,
        variant: Color(0xFF3A229C),
        onVariant: Colors.white,
        container: Color(0xFF8044FF),
        onContainer: Colors.white
      ),
      SupportingColors.orange: SupportingColorData(
        primary: Color(0xFFFF9567),
        onPrimary: Colors.white,
        variant: Color(0xFFB95B33),
        onVariant: Colors.white,
        container: Color(0xFFFF9567),
        onContainer: Colors.white
      ),
    SupportingColors.pink: SupportingColorData(
        primary: Color(0xFFFF67B0),
        onPrimary: Colors.white,
        variant: Color(0xFFC5397C),
        onVariant: Colors.white,
        container: Color(0xFFFF67B0),
        onContainer: Colors.white
      ),
    SupportingColors.purple: SupportingColorData(
        primary: Color(0xFFBB67FF),
        onPrimary: Colors.white,
        variant: Color(0xFF752DAF),
        onVariant: Colors.white,
        container: Color(0xFFBB67FF),
        onContainer: Colors.white
      ),
    SupportingColors.red: SupportingColorData(
        primary: Color(0xFFFC5B5B),
        onPrimary: Colors.white,
        variant: Color(0xFFB22525),
        onVariant: Colors.white,
        container: Color(0xFFFC5B5B),
        onContainer: Colors.white
      ),
    SupportingColors.yellow: SupportingColorData(
        primary: Color(0xFFD4CE30),
        onPrimary: Colors.white,
        variant: Color(0xFFA59F1B),
        onVariant: Colors.white,
        container: Color(0xFFD4CE30),
        onContainer: Colors.white
      ),
    SupportingColors.turqoise: SupportingColorData(
        primary: Color(0xFF3DD5DE),
        onPrimary: Colors.white,
        variant: Color(0xFF2C979E),
        onVariant: Colors.white,
        container: Color(0xFF3DD5DE),
        onContainer: Colors.white
      ),
    SupportingColors.eucalyptus: SupportingColorData(
        primary: Color(0xFF48DDB0),
        onPrimary: Colors.white,
        variant: Color(0xFF289B80),
        onVariant: Colors.white,
        container: Color(0xFF48DDB0),
        onContainer: Colors.white
      ),
      SupportingColors.sand: SupportingColorData(
        primary: Color(0xFFFFD37E),
        onPrimary: Colors.white,
        variant: Color(0xFFB07F20),
        onVariant: Colors.white,
        container: Color(0xFFFFD37E),
        onContainer: Colors.white
      ),
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
      ),
      highlightElevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      elevation: 0,
      // extendedPadding: EdgeInsets.symmetric(
      //   vertical: 10,
      //   horizontal: 20
      // ),
      // extendedSizeConstraints: BoxConstraints(minHeight: 0)
    ),

    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF2F2F2),
      secondarySelectedColor: Colors.red,
      selectedColor: Colors.black,
      labelStyle: textThemeFontSizes.bodyMedium?.copyWith(
        color: Colors.grey[700]
      ),
      elevation: 2,
      checkmarkColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide.none
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
    popupMenuTheme: PopupMenuThemeData(
      elevation: 8,      
      shape: RoundedRectangleBorder(
        borderRadius: radiuses.medium
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
      titleSmall: textThemeFontSizes.titleSmall?.copyWith(
        fontWeight: FontWeight.bold
      ),
      titleMedium: textThemeFontSizes.titleMedium?.copyWith(
        fontWeight: FontWeight.w900
      ),
      bodyMedium: textThemeFontSizes.bodyMedium?.copyWith(
        fontWeight: FontWeight.bold
      ),
      bodyLarge: textThemeFontSizes.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold
      ),
      headlineSmall: textThemeFontSizes.headlineSmall?.copyWith(
        fontWeight: FontWeight.w900
      ),
      labelLarge: textThemeFontSizes.labelLarge?.copyWith(
        fontWeight: FontWeight.bold
      ),
      titleLarge: textThemeFontSizes.titleLarge?.copyWith(
        fontWeight: FontWeight.bold
      ),

    ).apply(
      bodyColor: Colors.black,
      displayColor: Colors.black
    ),

    colorScheme: colorScheme,
    extensions: [
      ButtonThemes(
        error: TextButton.styleFrom(
          foregroundColor: colorScheme.onErrorContainer,
          backgroundColor: colorScheme.errorContainer
        ),
        success: TextButton.styleFrom(
          foregroundColor: colors.onSuccess,
          backgroundColor: colors.success
        ),
      ),
      colors,
      radiuses,
      const PaddingsTheme(
        medium: 20, 
        big: 30, 
        small: 12,
        tiny: 3
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
            padding: (density) {
               if (density == VisualDensity.compact) {
                return const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 18
                );
              } else if (density == VisualDensity.comfortable) {
                return const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 18
                );
              } else {
                return const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 18
                );
              }
            },
            minHeight: (density) {
              if (density == VisualDensity.compact) {
                return 25;
              } else if (density == VisualDensity.comfortable) {
                return 50;
              } else {
                return 45;
              }
            },
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

  