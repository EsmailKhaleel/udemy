// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:tutorial_app/components/customWidget/taskItem.dart';

Widget tasksBuilder({
  required List<Map> tasks,
})=>ConditionalBuilder(
            condition: tasks.isNotEmpty,
            builder: (context) => ListView.separated(
                itemBuilder: (context, index) =>
                    taskItem(tasks[index], context),
                separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ),
                itemCount: tasks.length),
            fallback: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.grey,
                    size: 100.0,
                  ),
                  Text(
                    'No Tasks Yet, Please Add Some Tasks !',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          );