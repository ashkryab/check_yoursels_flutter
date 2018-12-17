import 'package:check_yourself/repository/models/Task.dart';

abstract class TaskListView{
  void showTasks(List<Task> result) {}

}