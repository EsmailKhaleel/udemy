// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_null_comparison, curly_braces_in_flow_control_structures

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/Screens/bmiResultScren.dart';
import 'package:tutorial_app/Screens/bmi_screen.dart';
import 'package:tutorial_app/Screens/counter/counter.dart';
import 'package:tutorial_app/Screens/counter/cubit/cubit.dart';
import 'package:tutorial_app/Screens/counter/cubit/states.dart';
import 'package:tutorial_app/components/style/themes.dart';
import 'package:tutorial_app/layout/newsApp/new_layout.dart';
import 'package:tutorial_app/layout/todoApp/home_layout.dart';
import 'package:tutorial_app/network/remote/dioHelper.dart';
import 'package:tutorial_app/shop_app/cubit/cubit.dart';
import 'package:tutorial_app/shop_app/login/shopLoginScreen.dart';
import 'package:tutorial_app/shop_app/on_boarding/onBoardingScreen.dart';
import 'package:tutorial_app/shop_app/shared_preferences/cache_helper.dart';
import 'package:tutorial_app/shop_app/shop_layout/shopLayout.dart';
import 'package:tutorial_app/social_app/modules/social_login/socialLoginScreen.dart';
import 'components/constants/constants.dart';
import 'shared/blocObserver.dart';

// main method__________________________________________________________________
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //
  DioHelper.init();
  await CacheHelper.init();
  //
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  try {
    token = CacheHelper.getData(key: 'token');
  } catch (e) {
    print(e.toString());
  }
  //
  Widget? widget;

  if (onBoarding != null) {
    if (token != null)
      widget = ShopLayout();
    else
      widget = ShopLoginScreen();
  } else {
    widget = OnBoardingScreen();
  }

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        onBoarding: onBoarding,
        startWidget: widget!,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}
//end of main method____________________________________________________________

// MaterialApp Class____________________________________________________________

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final Widget? startWidget;
  MyApp({
    this.onBoarding,
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home: startWidget,
    );
  }
}
