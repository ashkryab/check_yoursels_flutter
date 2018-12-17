import 'package:check_yourself/repository/models/Task.dart';
import 'package:check_yourself/ui/create_task_page/CreateTaskPage.dart';
import 'package:check_yourself/ui/task_list_screen/TaskItemWidged.dart';
import 'package:check_yourself/ui/task_list_screen/TaskListPresenter.dart';
import 'package:check_yourself/ui/task_list_screen/TaskListView.dart';
import 'package:flutter/material.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> implements TaskListView {
  TaskListPresenter _presenter;

  @override
  void initState() {
    print("XXX_init");
    _presenter = TaskListPresenter(this);
    _presenter.loadTasks();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("XXX_build");
    return createBody();
  }

 Widget createBody(){
   return Scaffold(
     appBar: AppBar(
       title: Text(widget.title),
     ),
     body: Center(
         child: buildList()
     ),
     floatingActionButton: FloatingActionButton(
       onPressed:  () async{
         await Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => CreateTaskPage()),
         );
         _presenter.loadTasks();
       },
       child: Icon(Icons.add),
     ),
   );
 }

  @override
  void showTasks(List<Task> result) {
    setState(() {
      _presenter.items = result;
    });
  }

  Widget buildList(){
    if(_presenter.items.length>0){
     return  ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            TaskItemWidget(_presenter.items[index]),
        itemCount:_presenter.items.length,);
    }else{
      return Center(child: Text("Жмякни на плюсик и добавь напоминалку"));
    }
  }
}