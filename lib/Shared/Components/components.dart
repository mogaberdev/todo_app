// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Shared/bloc/cubit.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required String label,
  required IconData prefix,
  IconData? suffix,
  required String? Function(String?)? validate,
  Function()? onTap,
  Function(String?)? onSubmit,
  Function(String?)? onChange,
  bool isClickable = true,
})
=> TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validate,
  onTap: onTap,
  onChanged: onChange,
  onFieldSubmitted: onSubmit,
  enabled: isClickable,
  decoration: InputDecoration(
    border: OutlineInputBorder(),
    labelText: label,
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ? Icon(suffix) : suffix = null,
  ),
);

Widget buildTaskItem(Map model, context)
=> Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction)
  {
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
              '${model['time']}'
  
          ),
  
        ),
  
        SizedBox(width: 20.0),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                    color: Colors.grey
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(width: 20.0),
  
        IconButton(
  
            onPressed: ()
  
            {
  
              AppCubit.get(context).updateData(id: model['id'], status: 'done');
  
            },
  
            icon: Icon(
  
                Icons.check_box,
  
                color: Colors.green,
  
            ),
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {
  
            AppCubit.get(context).updateData(id: model['id'], status: 'archive');
  
          },
  
          icon: Icon(
  
              Icons.archive,
  
              color: Colors.redAccent,
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
);

Widget taskBuilder
({
  required List<Map> tasks,
})
=> ConditionalBuilder(
  condition: tasks.isNotEmpty,
  builder: (context) => ListView.separated(
    itemBuilder: (context,index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context,index) => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    ),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center ,
      children:
      [
        Icon(Icons.menu, size: 100.0, color: Colors.grey,),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        )
      ],
    ),
  ),
);