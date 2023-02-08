// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tutorial_app/Screens/archived_tasks/archivedTasksScreen.dart';
import 'package:tutorial_app/Screens/done_tasks/doneTasksScreen.dart';
import 'package:tutorial_app/Screens/new_tasks/newTasksScreen.dart';
import 'package:tutorial_app/components/customWidget/customTextField.dart';
import 'package:tutorial_app/shared/cubit/cubit.dart';
import 'package:tutorial_app/shared/cubit/states.dart';

import '../../components/constants/constants.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.title[cubit.indexed]),
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDataBaseLoadingState,
              builder: (context) => cubit.screens[cubit.indexed],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (() {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Form(
                          key: formKey,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextField(
                                  hint: 'Task Title',
                                  icon: Icons.title,
                                  controller: titleController,
                                  label: 'Task Title',
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must be not empty';
                                    }
                                  },
                                  type: TextInputType.text,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  hint: 'Task Time',
                                  icon: Icons.watch_later,
                                  controller: timeController,
                                  label: 'Task Time',
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must be not empty';
                                    }
                                  },
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) => {
                                          timeController.text =
                                              value!.format(context).toString()
                                        });
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomTextField(
                                  hint: 'Task Date',
                                  icon: Icons.calendar_today,
                                  controller: dateController,
                                  label: 'Task Date',
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must be not empty';
                                    }
                                  },
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate:
                                                DateTime.parse("2022-05-30"))
                                        .then((value) => {
                                              dateController.text =
                                                  DateFormat.yMMMd()
                                                      .format(value!)
                                                      .toString()
                                            });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20.0,
                      )
                      .closed
                      .then((value) => {
                            cubit.changeBottomSheet(
                                isShow: false, icon: Icons.edit)
                          });
                  cubit.changeBottomSheet(isShow: true, icon: Icons.add);
                }
              }),
              child: Icon(
                cubit.fabIcon,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.indexed,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),
    );
  }
}
