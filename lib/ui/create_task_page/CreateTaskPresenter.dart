import 'package:check_yourself/repository/DBHelper.dart';
import 'package:check_yourself/repository/models/Task.dart';
import 'package:check_yourself/ui/create_task_page/CreateTaskView.dart';

class CreateTaskPresenter {
  CreateTaskView view;
  Task task= Task();

//  get items => _items;

  CreateTaskPresenter(this.view) {
    task.maxCount=0;
    task.lastUpdate = "${DateTime.now().millisecondsSinceEpoch}";
  }

  bool addTask() {
    if(task.title == null || task.title.isEmpty
    || task.description == null || task.description.isEmpty) {
      view.showError("Fill all fields");
      return false;
    }
    DBHelper().saveTask(task);
    return true;
  }
}
