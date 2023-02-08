// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/layout/newsApp/Screens/business/businessScreen.dart';
import 'package:tutorial_app/layout/newsApp/Screens/science/scienceScreen.dart';
import 'package:tutorial_app/layout/newsApp/Screens/sports/sportsScreen.dart';
import 'package:tutorial_app/layout/newsApp/states.dart';
import 'package:tutorial_app/network/remote/dioHelper.dart';
import 'package:tutorial_app/shared/cubit/states.dart';

import 'Screens/settingsScreen/settingsScreen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeBottomNavBar(index) {
    currentIndex = index;
    emit(NewsBottomNavBarState());
  }

  List<BottomNavigationBarItem> botomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];
  List<Widget> screens = [
    BusinesssScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'users',
      query: {},
    ).then((value) {
      business = value.data;
      print(value.data[0]['name']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error));

      print(error.toString());
    });
  }
}
