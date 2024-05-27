import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skin_disease_backup/features/student_register/presentation/screen/register_ui.dart';
import '../features/home/presentation/screen/home_ui.dart';

class SkinDiseaseApp extends StatelessWidget {
  const SkinDiseaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'HelveticaNeue',
              textTheme: _TextTheme._textLightTheme),
          home: child,
        );
      },
      child: const RegisterUI(),
    );
  }
}

class _TextTheme {
  static final _textLightTheme = TextTheme(
    ///DISPLAY
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    //HEADLINE
    headlineLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    //TITLE
    titleLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    //BODY
    bodyLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),

    //LABEL
    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  );

  //DARK MODE
  static final _textDarkTheme = TextTheme(
    ///DISPLAY
    displayLarge: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontSize: 28.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    //HEADLINE
    headlineLarge: TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    //TITLE
    titleLarge: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    //BODY
    bodyLarge: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    //LABEL
    labelLarge: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}
