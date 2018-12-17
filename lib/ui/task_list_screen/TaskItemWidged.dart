import 'package:check_yourself/repository/DBHelper.dart';
import 'package:check_yourself/repository/models/Task.dart';
import 'package:flutter/material.dart';

class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget(this.task);

  final Task task;

  @override
  TaskItemWidgetState createState() {
    return new TaskItemWidgetState();
  }
}

class TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
          if(widget.task.currentCount!=0) {
            widget.task.currentCount -= 1;
            DBHelper().updateTask(widget.task);
          }
        });
      },
      child: Container(
        decoration: ShapeDecoration(
            shape:
                Border(bottom: BorderSide(color: Color(0xFFDDDDDD), width: 1))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //text
              Column(
                children: <Widget>[
                  //title
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.task.title,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  //description
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      widget.task.description,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              //checkbox
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isComplete(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isComplete() {
    if (widget.task.currentCount == 0) {
      return Icon(
        Icons.done,
        color: Colors.green,
      );
    } else {
      return Text(
        '${widget.task.currentCount}',
        style: TextStyle(
          fontSize: 18,
        ),
      );
    }
  }
}
