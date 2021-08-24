import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/cubit/cubit.dart';

// ignore: non_constant_identifier_names
Widget DefaultTextField({
  required String label,
  required TextEditingController controller,
  required TextInputType type,
  required IconData icon,
  // required Function(String)? onSubmit,
  // required Function(String)? onChange,
  required Function()? onTap,
  required String? Function(String?)? validate,
}) {
  return TextFormField(
    validator: validate,
    controller: controller,
    keyboardType: type,
    // onChanged: onChange,
    // onFieldSubmitted: onSubmit,
    onTap: onTap,
    decoration: InputDecoration(
      fillColor: Colors.white,
      border: OutlineInputBorder(),
      labelText: label,
      prefixIcon: Icon(
        icon,
      ),
    ),
  );
}

Widget buildTaskTime(Map maap, context) {
  return Dismissible(
    key: Key(maap['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 30,
            child: Text(
              '${maap["time"]}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${maap["title"]}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  '${maap["data"]}',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: maap["id"]);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: maap["id"]);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.red,
              )),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: maap['id']);
    },
  );
}

Widget buildTaskTimetest(Map maap, context, Animation<double> animation) {
 
  return Dismissible(
    key: Key(maap['id'].toString()),
    child: AnimatedContainer(
      duration: Duration(seconds: 2),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: 30,
            child: Text(
              '${maap["time"]}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${maap["title"]}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  '${maap["data"]}',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: maap["id"]);
              },
              icon: Icon(
                Icons.check_box,
                color: Colors.green,
              )),
          IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: maap["id"]);
              },
              icon: Icon(
                Icons.archive,
                color: Colors.red,
              )),
        ],
      ),
    ),
    onDismissed: (direction) {
      AppCubit.get(context).deleteData(id: maap['id']);
    },
  );
}
