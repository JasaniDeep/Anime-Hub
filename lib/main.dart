import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:movie_app/constants/common_string.dart';
import 'package:movie_app/theme/app_theme.dart';
import 'package:movie_app/utils/network_http.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'utils/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ApiHandler.init();
  // AppPages.initRouting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: CommonString.elariya,
      builder: FToastBuilder(),
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.splashScreen,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
