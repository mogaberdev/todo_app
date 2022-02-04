// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/bloc/cubit.dart';
import 'package:todo_app/Shared/bloc/states.dart';

class ArchivedTasksScreen extends StatelessWidget {
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context, state)
      {
        var tasks = AppCubit.get(context).archivedTasks;
        return taskBuilder(tasks: tasks);
      },

    );
  }
}
