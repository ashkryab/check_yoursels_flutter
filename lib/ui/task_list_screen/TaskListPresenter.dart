import 'package:check_yourself/repository/DBHelper.dart';
import 'package:check_yourself/repository/models/Task.dart';
import 'package:check_yourself/ui/task_list_screen/TaskListView.dart';

class TaskListPresenter {
  TaskListView _view;
  List<Task> items;

//  get items => _items;

  TaskListPresenter(TaskListView view) {
    items = List();
    _view = view;
  }

  void loadTasks() {
    DBHelper().getTasks().then((result) {
      result.forEach(checkDate);
      _view.showTasks(result);
    });
  }

  void checkDate(Task task) {
//    var oldDate = DateTime.fromMillisecondsSinceEpoch(num.parse(task.lastUpdate));
    int oldDay = num.parse(task.lastUpdate) ~/ (1000 * 60 * 60 * 24);
    int current =
        DateTime.now().millisecondsSinceEpoch ~/ (1000 * 60 * 60 * 24);
    var dif = current - oldDay;
    if (dif > 0) {
      task.lastUpdate = "$current";
      task.currentCount = task.maxCount;
      DBHelper().updateTask(task);
    }
  }

  void deleteItem(task) {
    DBHelper().deleteTask(task);
  }
}
