import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_1/modules/To_do_app/Archive_task/archived_task.dart';
import 'package:flutter_app_1/modules/To_do_app/Done_task/done_tasks.dart';
import 'package:flutter_app_1/modules/To_do_app/New_task/new_tasks.dart';
import 'package:flutter_app_1/shared/components/constants.dart';
import 'package:flutter_app_1/shared/cubit/cubit.dart';
import 'package:flutter_app_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';


class HomeLayout extends StatelessWidget
{

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void showToastMessage() {
    Fluttertoast.showToast(
      msg: "Flutter is the best",
      backgroundColor: Colors.black54,
      fontSize: 16.0,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }


  validator() {
    if (formkey.currentState != null && formkey.currentState!.validate()) {}
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>
        (
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit =  AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(title: titleController.text, time: timeController.text, date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) =>
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(
                            20.0,
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (String? value) {
                                    if (value == null || value
                                        .trim()
                                        .isEmpty) {
                                      return 'Enter a title';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.title,
                                    ),
                                    label: Text('Task title'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context).toString());
                                    });
                                  },
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  onChanged: (String value) {
                                    print(value);
                                  },

                                  validator: (String? value) {
                                    if (value == null || value
                                        .trim()
                                        .isEmpty) {
                                      return 'Enter a time';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.access_time_outlined,
                                    ),
                                    label: Text('Time'),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      initialDate: DateTime.now() ,
                                      firstDate: DateTime.now(),
                                      context: context ,
                                      lastDate: DateTime.parse('2100-01-01'),
                                    ).then((value) {
                                      dateController.text = DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  onFieldSubmitted: (String value) {
                                    print(value);
                                  },
                                  onChanged: (String value) {
                                    print(value);
                                  },
                                  validator: (String? value) {
                                    if (value == null || value
                                        .trim()
                                        .isEmpty) {
                                      return 'Enter a date';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                    ),
                                    label: Text('Date'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    elevation: 20.0,
                  ).closed.then((value)
                  {
                    cubit.changeBottomSheetState(isShow: false, icon:Icons.edit );
                  });
                  cubit.changeBottomSheetState(isShow: true, icon:Icons.add );

                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outlined),
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

