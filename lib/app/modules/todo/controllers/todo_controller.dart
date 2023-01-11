import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/data/todo_data.dart';
import 'package:getx_todo/app/model/todo.dart';

class TodoController extends GetxController {
  //TODO: Implement TodoController

  final count = 0.obs;
  final todos = todosData.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  var status = false.obs;

  void increment() => count.value++;

  void addTodo() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter todo content",
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return;
    }
    todos.add(
      Todo(
        id: todos.length + 1,
        title: titleController.text,
        status: status.value,
        description: titleController.text,
      ),
    );
    titleController.text = "";
    descriptionController.text = "";
    Get.back();
    inspect(todos);
  }

  void updateTodo(int id) {
    final todo = todos.firstWhere((item) => item.id == id);

    final index = todos.indexOf(todo);
    if (index == -1) return;

    todo.status = todo.status;
    todos[index] = todo;
  }

  void deleteTodo(int id) {
    todos.removeWhere((item) => item.id == id);
  }

  void showModelForm() {
    Get.bottomSheet(
      Card(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 24,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Title",
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(hintText: "Todo title"),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Description"),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 16,
              ),
              const Text("Status"),
              Row(
                children: <Widget>[
                  Obx(() => Expanded(
                        child: RadioListTile(
                          title: const Text("Complete"),
                          value: true,
                          groupValue: status.value,
                          onChanged: (value) {
                            status.value = value!;
                          },
                        ),
                      )),
                  Obx(() => Expanded(
                        child: RadioListTile(
                          title: const Text("Incomplete"),
                          value: false,
                          groupValue: status.value,
                          onChanged: (value) {
                            status.value = value!;
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      )),
                ],
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      addTodo();
                    },
                    child: const Text("Add"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
