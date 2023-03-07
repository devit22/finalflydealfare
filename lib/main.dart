
import 'package:country_picker/country_picker.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fly_deal_fare/SplashScreen.dart';
import 'package:fly_deal_fare/ui/login_screen.dart';
import 'package:fly_deal_fare/ui/notification_screen.dart';
import 'package:fly_deal_fare/ui/root_home_screen.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',

  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
         Locale('en'),
         Locale('el'), // Generic traditional Chinese 'zh_Hant'
      ],
      localizationsDelegates: const [
        CountryLocalizations.delegate,
      ],
      title: 'FlyDealFare',
      // theme of the widget
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: Colors.blue,

          // or from RGB

          // primary: const Color(0xFF343A40),
          // secondary: const Color(0xFFFFC107),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
          secondary: Colors.white,
        ),
      ),
      color: Colors.blue,
      //home: HomeScreen(),
      home: EntryPackage(),
    );
  }
}


