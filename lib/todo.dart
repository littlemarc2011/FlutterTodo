import 'package:flutter/material.dart';
import 'main.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';
import 'dart:collection';

class TodoObject {
  TodoObject(String title, IconData icon) {
    this.title = title;
    this.icon = icon;
    this.color = ColorChoies.colors[new Random().nextInt(ColorChoies.colors.length)];
    this.gradient = LinearGradient(colors: ColorChoies.gradients[new Random().nextInt(ColorChoies.gradients.length)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
    tasks = new Map<DateTime, List<TaskObject>>();
    this.uuid = new Uuid().v1();
  }

  TodoObject.import(String uuidS, String title, int sortID, List<Color> color, IconData icon, Map<DateTime, List<TaskObject>> tasks) {
    this.sortID = sortID;
    this.title = title;
    this.gradient = LinearGradient(colors: color, begin: Alignment.bottomCenter, end: Alignment.topCenter);
    this.icon = icon;
    this.tasks = tasks;
    this.uuid = uuidS;
  }

  String uuid;
  int sortID;
  String title;
  Color color;
  LinearGradient gradient;
  IconData icon;
  Map<DateTime, List<TaskObject>> tasks;

  int taskAmount() {
    int amount = 0;
    tasks.values.forEach((list) {
      amount += list.length;
    });
    return amount;
  }

  //List<TaskObject> tasks;

  double percentComplete() {
    if (tasks.isEmpty) {
      return 1.0;
    }
    int completed = 0;
    int amount = 0;
    tasks.values.forEach((list) {
      amount += list.length;
      list.forEach((task) {
        if (task.isCompleted()) {
          completed++;
        }
      });
    });
    return completed / amount;
  }
}

class TaskObject {
  DateTime date;
  String task;
  bool _completed;

  TaskObject(String task, DateTime date) {
    this.task = task;
    this.date = date;
    this._completed = false;
  }

  TaskObject.import(String task, DateTime date, bool completed) {
    this.task = task;
    this.date = date;
    this._completed = completed;
  }

  void setComplete(bool value) {
    _completed = value;
  }

  isCompleted() => _completed;
}
