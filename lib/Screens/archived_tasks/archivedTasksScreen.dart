// ignore_for_file: prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/customWidget/tasksBuilder.dart';
import 'package:tutorial_app/shared/cubit/cubit.dart';
import 'package:tutorial_app/shared/cubit/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = BlocProvider.of(context);
            var tasks = AppCubit.get(context).archivedtasks;

          return tasksBuilder(tasks: tasks,);
        });
  }
}
