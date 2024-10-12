import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:souls_master/constants/pages.dart';
import 'package:souls_master/constants/theme.dart';
import 'package:souls_master/routes/named_route.dart';
import 'package:flutter/services.dart';
import 'constants/my_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app orientation to portrait mode
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set the bottom navigation bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: MyColor.androidBottomNavBarColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: MyTheme.buildTheme(),
      getPages: Pages.getPages,
      locale: const Locale('fa'),
      initialRoute: NamedRoute.initialRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
