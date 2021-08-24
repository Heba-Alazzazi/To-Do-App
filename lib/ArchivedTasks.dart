import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Custom.dart';
import 'cubit/constant.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ArchivedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          //var list = AppCubit.get(context).archivedtasks;

          // return AnimatedList(
          //     key: AppCubit.get(context).animatedKey,
          //     itemBuilder: (context, index, animation) {
          //       return buildTaskTime(archivedtasks[index], context, animation);
          //     },
          return ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskTime(archivedtasks[index], context);
              },
              separatorBuilder: (context, index) {
                return Container(
                  //padding: EdgeInsets.only(left: 40),
                  width: double.infinity,
                  height: 1,
                  color: Colors.black,
                );
              },
              itemCount: archivedtasks.length);
        });
  }
}
