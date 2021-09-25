import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/src/common/constraint.dart';
import 'package:todoapp/src/models/task.dart';

class TaskCard extends StatefulWidget {
  @override
  final Task task;
  TaskCard({required this.task});
  State<StatefulWidget> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool? value = false;
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(8.0))),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  height: 48,
                  width: 6,
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(12))),
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(widget.task.title,
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(widget.task.subTitle,
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(
                      DateFormat('hh:mm: a - dd/MM/yyyy').format(widget.task.deadline),
                        style: TextStyle(
                          color: colorPrimary,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 2.0,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 10,
            ),
            child: Checkbox(
              value: value,
              onChanged: (value) => {
                setState(() {
                  this.value = value;
                })
              },
            ),
          )
        ],
      ),
    );
  }
}
