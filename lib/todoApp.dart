import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/cubit/cubit.dart';
import 'package:todo_app/cubit/states.dart';

import 'Custom.dart';

class TodoApp extends StatefulWidget {
  @override
  TodoAppState createState() => TodoAppState();
}

class TodoAppState extends State<TodoApp> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleTextController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDataBaseState) {
          Navigator.of(context).pop();
        }
      }, builder: (BuildContext context, AppStates state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(AppCubit.get(context)
                .titles[AppCubit.get(context).currentIndex]),
          ),

          body: state is AppGetDataBaseLoadState
              ? Center(child: CircularProgressIndicator())
              : AppCubit.get(context)
                  .screens[AppCubit.get(context).currentIndex],

          // body: ConditionalBuilder(
          //   condition: tasks.length > 0,
          //   builder: (context) => screens[currentIndex],
          //   fallback: (context) => Center(child: CircularProgressIndicator()),
          // ),

          bottomNavigationBar: BottomNavigationBar(
              currentIndex: AppCubit.get(context).currentIndex,
              onTap: (int index) {
                AppCubit.get(context).changeIndex(index);
                // setState(() {});
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: "Task"),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: "Done"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_rounded), label: "Archived"),
              ]),

          floatingActionButton: FloatingActionButton(
            child: Icon(AppCubit.get(context).icoon),
            onPressed: () {
              if (AppCubit.get(context).isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  print("before insert");
                  AppCubit.get(context)
                      .insertToDatabase(
                          lable: titleTextController.text,
                          time: timeController.text,
                          dateText: dateController.text)
                      .then(
                    (value) {
                      print("after insert");
                      // AppCubit.get(context)
                      //     .getDataFromDataBase(AppCubit.get(context).database)
                      //     .then((value) {
                      //   //Navigator.pop(context);

                      //   AppCubit.get(context).changeBottomSheetState(
                      //       isShow: false, icon: Icons.edit);

                      //   //tasks = value;
                      // });
                    },
                  );
                }
              } else {
                scaffoldKey.currentState!
                    .showBottomSheet(
                      (context) {
                        return Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          //height: 300,
                          color: Colors.grey[100],
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  DefaultTextField(
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "The Title is required";
                                        }
                                      },
                                      label: "Task Title",
                                      controller: titleTextController,
                                      type: TextInputType.text,
                                      icon: Icons.title,
                                      onTap: () {}),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DefaultTextField(
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "The Time is required";
                                        }
                                      },
                                      label: " Task Time",
                                      controller: timeController,
                                      type: TextInputType.datetime,
                                      icon: Icons.watch_outlined,
                                      onTap: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                        });
                                      }
                                      // onSubmit:(){},
                                      // onChange: onChange
                                      ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  DefaultTextField(
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return "The Date is required";
                                        }
                                      },
                                      label: " Task Date",
                                      controller: dateController,
                                      type: TextInputType.text,
                                      icon: Icons.calendar_today,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2022-01-09'))
                                            .then((value) {
                                          dateController.text =
                                              DateFormat.yMMM().format(value!);
                                        });
                                      }
                                      // onSubmit:(){},
                                      // onChange: onChange
                                      ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      elevation: 20.0,
                    )
                    .closed
                    .then((value) {
                      AppCubit.get(context).changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });
                AppCubit.get(context)
                    .changeBottomSheetState(isShow: true, icon: Icons.add);
              }
            },
          ),
        );
      }),
    );
  }

  // getDataFromDataBase(database) {}
}
