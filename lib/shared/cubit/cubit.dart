import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/modules/To_do_app/Archive_task/archived_task.dart';
import 'package:flutter_app_1/modules/To_do_app/Done_task/done_tasks.dart';
import 'package:flutter_app_1/modules/To_do_app/New_task/new_tasks.dart';
import 'package:flutter_app_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialsStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChaneBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> donTasks = [];
  List<Map> archivedTasks = [];
  void createDatabase()  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        // 1 id Int
        // 2 title String
        // 3 date String
        // 4 time String
        // 5 status String
        print('Database Create');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT, date TEXT, time TEXT , status TEXT)')
            .then((value) {
          print('Table Created');
        }).catchError((error) {
          print('Error was found when creating table ${error.toString}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('DB Opened');
      },
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time ,status) VALUES("$title","$date","$time","New")')
          .then((value) {
        print('$value inserted successfully!');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting a record ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database)
  {
    emit(AppGetDatabaseLoadingState());

    database.rawQuery('SELECT * FROM tasks').then((value)
    {

      value.forEach((element){
        if (element['status'] == 'new') {
          newTasks.add(element);
        }
        else if (element['status'] == 'done') {
          donTasks.add(element);}
        else {
          archivedTasks.add(element);
        }
      });

      emit(AppGetDatabaseState());
    });
  }

  void UpdateData({
  required String status,
  required int id,

})
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]
    ).then((value){
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({
  required bool isShow,
  required IconData icon,
})
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChaneBottomSheetState());
  }

}