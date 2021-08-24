import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/cubit.dart';

import 'Custom.dart';
import 'cubit/constant.dart';
import 'cubit/states.dart';

class NewTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // return AnimatedList(
          //     //key: AppCubit.get(context).animatedKey,
          //     initialItemCount: newtasks.length,
          //     itemBuilder: (context, index, animation) {
          //       return buildTaskTime(newtasks[index], context, animation);
          //     });
          // return AnimatedList(
          //   initialItemCount: newtasks.length,
          //   itemBuilder: (context, index, animation) {
          //     return buildTaskTimetest(newtasks[index], context, animation);
          //   },
          // );

          return ListView.separated(
              key: AppCubit.get(context).animatedKey,
              itemBuilder: (context, index) {
                return buildTaskTime(newtasks[index], context);
              },
              separatorBuilder: (context, index) {
                return Container(
                  //padding: EdgeInsets.only(left: 40),
                  width: double.infinity,
                  height: 1,
                  color: Colors.black,
                );
              },
              itemCount: newtasks.length);
        });
  }
  // return Container(
  //   width: 150,
  //   height: 150,
  //   color: Colors.blue,
  // );

}
