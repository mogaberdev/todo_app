// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Modules/info_screen/info.dart';
import 'package:todo_app/Shared/Components/components.dart';
import 'package:todo_app/Shared/bloc/cubit.dart';
import 'package:todo_app/Shared/bloc/states.dart';

class HomeLayout extends StatelessWidget
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDataToDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              leading: IconButton(icon: Icon(Icons.info_outline), onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactMe()));
              },
              ),
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()
              {
                if(cubit.isBottomSheetShown)
                {
                  if(formKey.currentState!.validate())
                  {
                    cubit.insertToDatabase(title: titleController.text, date: dateController.text, time: timeController.text);
                    // insertToDatabase(
                    //   title: titleController.text,
                    //   date: dateController.text,
                    //   time: timeController.text,
                    // ).then((value)
                    // {
                    //   getDataFromDatabase(database).then((value)
                    //   {
                    //     Navigator.pop(context);
                    //     // setState(() {
                    //     //   isBottomSheetShown = false;
                    //     //   fabIcon = Icons.edit;
                    //     //   tasks = value;
                    //     // });
                    //   });
                    // });
                  }
                } else {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children:
                          [
                            defaultFormField(
                              controller: titleController,
                              type: TextInputType.text,
                              label: 'Task Title',
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return  "Title Mustn't Be Empty";
                                } return null;
                              },
                              prefix: Icons.title,
                            ),
                            SizedBox(height: 20.0),
                            defaultFormField(
                              controller: timeController,
                              type: TextInputType.datetime,
                              label: 'Task Time',
                              onTap: ()
                              {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value)
                                {
                                  timeController.text = value!.format(context).toString();
                                });
                              },
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return  "You Have To Select Time";
                                } return null;
                              },
                              prefix: Icons.watch_later_outlined,
                            ),
                            SizedBox(height: 20.0),
                            defaultFormField(
                              controller: dateController,
                              type: TextInputType.text,
                              label: 'Task Date',
                              onTap: ()
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse('2099-12-31'),
                                ).then((value)
                                {
                                  dateController.text = DateFormat.yMMMd().format(value!);
                                }
                                );
                              },
                              validate: (value)
                              {
                                if(value!.isEmpty)
                                {
                                  return  "You Have To Select Date";
                                } return null;
                              },
                              prefix: Icons.calendar_today,
                            ),
                          ],
                        ),
                      ),
                    ),
                    elevation: 20.0,
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit
                    );
                  });
                    cubit.changeBottomSheetState(
                        isShow: true,
                        icon: Icons.add
                    );
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },
              items:
              [
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
              ],
            ),
          );
        },

      ),
    );
  }
}
