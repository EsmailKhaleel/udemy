// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_app/components/customWidget/tasksBuilder.dart';

import 'package:tutorial_app/shared/cubit/cubit.dart';
import 'package:tutorial_app/shared/cubit/states.dart';

import '../../components/constants/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasks = AppCubit.get(context).newtasks;
          AppCubit cubit = BlocProvider.of(context);

          return tasksBuilder(
            tasks: tasks,
          );
        });
  }
}
