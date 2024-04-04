import 'dart:async';
import 'dart:io';
import 'package:beehive/providers/home_provider_reciept.dart';
import 'package:beehive/providers/login_provider.dart';
import 'package:beehive/providers/main_provider.dart';
import 'package:beehive/service/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_strategy/url_strategy.dart';
import '../../providers/donation_provider.dart';
import '../../providers/home_provider.dart';
import '../providers/web_provider.dart';
import 'package:provider/provider.dart';
import 'Admin/subscriber_details.dart';
import 'QmchScreens/activity_home_screen.dart';
import 'QmchScreens/sponsorOnBoardingScreen.dart';
import 'QmchScreens/userActivityDetailsScreen.dart';
import 'QmchScreens/userEquipmentListScreen.dart';
import 'QmchScreens/userRegistrationScreen.dart';
import 'Screens/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String? paymentID;

  if(!kIsWeb) {
    await Firebase.initializeApp();
  }else {
    await Firebase.initializeApp(

        options:const FirebaseOptions(
            apiKey: "AIzaSyDFC9FMSDWeHMAGNT5XKCTfzSDB-W3wMIM",
            authDomain: "qmch-64ab5.firebaseapp.com",
            databaseURL: "https://qmch-64ab5-default-rtdb.firebaseio.com",
            projectId: "qmch-64ab5",
            storageBucket: "qmch-64ab5.appspot.com",
            messagingSenderId: "1024553868554",
            appId: "1:1024553868554:web:82bb51f097f1cd547faef3",
            measurementId: "G-V4WYKFGBYT"
        )

    );

  }
  if(!kIsWeb){
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    bool weWantFatalErrorRecording = true;
    FlutterError.onError = (errorDetails) {
      if(weWantFatalErrorRecording){
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      } else {
        FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
      }
    };

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    String strDeviceID= await DeviceInfo().fun_initPlatformState();
    FirebaseCrashlytics.instance.setUserIdentifier(strDeviceID);
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    runZonedGuarded(() {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((value) =>
      runApp( MyApp(paymentID: '',)));
    }, FirebaseCrashlytics.instance.recordError);



  }else{
    setPathUrlStrategy();
    String? refNum = Uri.base.queryParameters["id"];
    if(refNum==null){

      paymentID="General";

    }else{

      paymentID=refNum;

    }

    print("dssedsqwer"+paymentID.toString());


    runApp( MyApp(paymentID: paymentID!,));
  }


}

class MyApp extends StatelessWidget {
  String paymentID="";
   MyApp({Key? key,required this.paymentID}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (context)=>DonationProvider(),),
        ChangeNotifierProvider(create: (context)=>HomeProvider(),),
        ChangeNotifierProvider(create: (context)=>HomeProviderReceiptApp(),),
        ChangeNotifierProvider(create: (context)=>WebProvider(),),
        ChangeNotifierProvider(create: (context)=>LoginProvider(),),
        ChangeNotifierProvider(create: (context)=>MainProvider(),),
      ],
      child: MaterialApp(
        title: 'QMCH',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: TestPage(),
        // home: UploadLogIn(),
        // home: SubscriberDetails(),
        // home: AdminLoginScreen(),
        // home: UploadExcel(),
        home:  SplashScreen(paymentID:'',),///admin web
        // home:  SplashScreen(paymentID:paymentID,),///mobile app user
        // home:  LoginScreen(),
        // home:  const InagurationScreen(),
        // home: const   Intern(),
        // home:UserRegistrationScreen(),

      ),
    );
  }
}


