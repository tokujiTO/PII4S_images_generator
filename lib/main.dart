import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poliedroimagesgenerator/app/pages/chat_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/dev_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/history_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/home_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/init_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/loading_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/settings_page_view.dart';
import 'package:poliedroimagesgenerator/app/pages/signin_page.dart';
import 'package:poliedroimagesgenerator/app/pages/signup_page.dart';

void main() {
  runApp(DevicePreview(enabled: false, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poliedro Images',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Inter',
        ),
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        initialRoute: "/",
        routes: {
          '/': (_) => const DevPageView(),
          '/first': (_) => const FirstPage(),
          '/signup': (_) => const SignUpPage(),
          '/signin': (_) => const SignInPage(),
          '/loading': (_) => const LoadingPage(),
          '/home': (_) => const HomePage(),
          '/chat': (_) => const ChatPage(),
          '/history': (_) => const HistoryPage(),
          '/settings': (_) => const SettingsPageView(),
        },
      ),
    );
  }
}
