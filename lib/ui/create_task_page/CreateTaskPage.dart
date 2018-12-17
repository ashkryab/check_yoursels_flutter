import 'package:check_yourself/ui/create_task_page/CreateTaskPresenter.dart';
import 'package:check_yourself/ui/create_task_page/CreateTaskView.dart';
import 'package:flutter/material.dart';

class CreateTaskPage extends StatefulWidget {
  CreateTaskPage();

  final String title="Create Task";
  CreateTaskPresenter _presenter;

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage>
    implements CreateTaskView {
  CreateTaskPresenter _presenter;

  BuildContext _scaffoldContext;

  @override
  void initState() {
    print("recreate");
    _presenter = CreateTaskPresenter(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new Builder(builder: (BuildContext context) {
        _scaffoldContext = context;
        return Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32, right: 16, left: 16),
            child: TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(hintText: "Title"),
              onChanged: (str) {
                _presenter.task.title = str;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              textInputAction: TextInputAction.go,
              autofocus: true,
              decoration: InputDecoration(hintText: "Description"),
              onChanged: (str) {
                _presenter.task.description = str;
              },
            ),
          ),
          Expanded(
            child: Text(""),
          ),
          Column(
            children: <Widget>[
              Text("Count"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      shape: CircleBorder(),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          if (_presenter.task.maxCount == 0) return;
                          _presenter.task.maxCount -= 1;
                        });
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "${_presenter.task.maxCount}",
                      style: TextStyle(fontSize: 26),
                    ),
                    RaisedButton(
                      shape: CircleBorder(),
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {
                          _presenter.task.maxCount += 1;
                        });
                      },
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(child: Text("")),
          Expanded(child: Text("")),
        ]);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_presenter.addTask()) {
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void showError(String s) {
    Scaffold.of(_scaffoldContext).showSnackBar(SnackBar(
      content: Text(s),
      duration: Duration(seconds: 2),
    ));
  }
}
