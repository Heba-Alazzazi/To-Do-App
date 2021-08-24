import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/cubit/states.dart';
import '../ArchivedTasks.dart';
import '../DoneTasks.dart';
import '../NewTasks.dart';
import 'constant.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(contexr) {
    return BlocProvider.of(contexr);
  }

  int currentIndex = 0;
  late Database database;
  List<Widget> screens = [NewTasks(), DoneTasks(), ArchivedTasks()];
  List<String> titles = ["New Tasks ", "Done Tasks", "Archived Tasks"];

  var animatedKey = GlobalKey<AnimatedListState>();

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void creatDatabase() {
    openDatabase("todoApp.db", version: 1, onCreate: (database, version) async {
      print("DataBase created");
      database
          .execute(
              "CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, data TEXT,time TEXT , status TEXT)")
          .then((value) {
        print("Table Created");
      }).catchError((error) {
        print("Error when creating table");
      });
    }, onOpen: (Database database) {
      getDataFromDataBase(database);

      print("DataBase opend");
    }).then((value) {
      database = value;
      emit(AppCreateDataBaseState());
    });
  }

  Future<void> insertToDatabase({
    required String lable,
    required String time,
    required String dateText,
  }) async {
    database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks (title,data,time, status) VALUES ("$lable" ,"$dateText","$time" , "new" )')
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDataBaseState());

        getDataFromDataBase(database);
      }).catchError((error) {
        print("Error");
      });
      //throw Exception();
    });

    //return null;
  }

  void getDataFromDataBase(Database database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    emit(AppGetDataBaseLoadState());
    database.rawQuery('SELECT * FROM tasks').then((value) async {
      value.forEach((element) {
        if (element['status'] == 'new') {
          // ignore: unnecessary_statements
          newtasks.add(element);
        } else if (element['status'] == 'done') {
          donetasks.add(element);
        } else {
          archivedtasks.add(element);
        }
      });

      emit(AppGetDataBaseState());
      //throw Exception();
    });
  }

  void updateData({required String status, required int id}) async {
    await database.rawUpdate(" UPDATE tasks SET  status = ? WHERE id = ? ",
        ['$status', id]).then((value) {
      getDataFromDataBase(database);
      emit(AppUpdateDataBaseState());
    });
  }
  // void updateData(
  //     {required Map maap, required String status, required int id}) async {
  //   await database.rawUpdate(" UPDATE tasks SET  status = ? WHERE id = ? ",
  //       ['$status', id]).then((value) {
  //     getDataFromDataBase(database);
  //     emit(AppUpdateDataBaseState());
  //     AnimatedListRemovedItemBuilder builder = (context, animation) {
  //       return buildTaskTime(maap, id, animation);
  //     };
  //     animatedKey.currentState!.removeItem(id, builder);
  //     //animatedKey.currentState.
  //     //throw Exception();
  //   });
  // }

  void deleteData({required int id}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getDataFromDataBase(database);

      emit(AppDeleteDataBaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData icoon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    icoon = icon;
    emit(AppChangeBottomSheetState());
  }
}
