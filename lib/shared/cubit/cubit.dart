// ignore_for_file: avoid_function_literals_in_foreach_calls, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutorial_app/Screens/archived_tasks/archivedTasksScreen.dart';
import 'package:tutorial_app/Screens/done_tasks/doneTasksScreen.dart';
import 'package:tutorial_app/Screens/new_tasks/newTasksScreen.dart';
import 'package:tutorial_app/shared/cubit/states.dart';

import '../../components/constants/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivedtasks = [];

  int indexed = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> title = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index) {
    indexed = index;
    emit(AppChangeBottomVavBarState());
  }

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database database, int version) async {
        print('Database is created');

        await database
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('Tables are created');
        }).catchError((error) {
          print('error on create tables is ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDataBase(database);
        print('Database is opened');
      },
    ).then((value) => {
          database = value,
          emit(AppCreateDataBaseState()),
        });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    return await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO Tasks(title, date, time,status) VALUES("$title", "$date","$time","New" )')
          .then((value) {
        emit(AppInsertDataBaseState());
        print('$value inserted 1 successfully ');

        getDataFromDataBase(database);
      }).catchError((error) {
        print('error on inserting record is ${error.toString()}');
      });
    });
  }

  void getDataFromDataBase(Database database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(AppGetDataBaseLoadingState());

    database.rawQuery('SELECT * FROM Tasks').then((value) => {
          print(value),
          value.forEach((element) {
            if (element['status'] == 'New') {
              newtasks.add(element);
            } else if (element['status'] == 'done') {
              donetasks.add(element);
            } else {
              archivedtasks.add(element);
            }
          }),
          emit(AppGetDataBaseState()),
        });
  }

  void updateData({
    required String Status,
    required int id,
  }) async {
    database.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?', [
      Status,
      id
    ]).then((value) => {
          emit(AppUpdateDataBaseState()),
          getDataFromDataBase(database),
        });
  }

  void deleteData({

    required int id,
  }) async {
    database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]).then((value) => {
          getDataFromDataBase(database),
          emit(AppDeleteDataBaseState()),
        });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }
}
