import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Modules/archived_tasks/archived_tasks.dart';
import 'package:todo_app/Modules/done_tasks/done_tasks.dart';
import 'package:todo_app/Modules/new_tasks/new_tasks.dart';
import 'package:todo_app/Shared/bloc/states.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  int currentIndex = 0;
  List<Widget> screens = [NewTasksScreen(), DoneTasksScreen(), ArchivedTasksScreen()];
  List<String> titles = ['New Tasks','Done Tasks','Archived Tasks'];
  late Database database;
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void createDatabase()
  {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version)
        {
          print("database created");
          database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
            print("table created");
          }).catchError((error)
          {
            print('Error When Creating Table ${error.toString()}');
          });
        },
        onOpen: (database)
        {
          getDataFromDatabase(database);

          print("database opened");
        }
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }
  insertToDatabase({
    required String title,
    required String date,
    required String time
  }) async
  {
    await database.transaction((txn)
    {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")'
      ).then((value){
        print('$value Inserted Successfully');
        emit(AppInsertDataToDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error){print('Error When insert new record ${error.toString()}');});
      return Future.value(true);
    });
  }

  void getDataFromDatabase(database)
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value)
    {

      value.forEach((element)
      {
        if(element['status'] == 'new')
        {
          newTasks.add(element);
        } else if (element['status'] == 'done')
        {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDataFromDatabaseState());
    });
  }

  void updateData({
    required int id,
    required String status,
}) async
  {
     database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value)
     {
       getDataFromDatabase(database);
       emit(AppUpdateDatabaseState());
     });
  }

void changeBottomSheetState({
  required bool isShow,
  required IconData icon,
})
{
  isBottomSheetShown = isShow;
  fabIcon = icon;
  emit(AppChangeBottomSheetState());
}
  void deleteData({
    required int id,
  }) async
  {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value)
    {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

}
