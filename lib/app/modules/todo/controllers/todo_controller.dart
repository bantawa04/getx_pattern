import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/app/model/todo.dart' show Todo, TodoRequest;
import 'package:getx_todo/network/api_handler.dart';

class TodoController extends GetxController {
  //TODO: Implement TodoController

  final count = 0.obs;
  // final todos = todosData.obs;
  RxList<Todo> todos = <Todo>[].obs;

  final titleController = TextEditingController();
  var completed = false.obs;

  void increment() => count.value++;
  final ApiService apiService = ApiService();
  RxBool isDataLoaded = false.obs;

  @override
  void onInit() async {
    isDataLoaded.value = false;
    Future.delayed(const Duration(seconds: 2), () async {
      var response = await apiService.getTodos('/todos?limit=5');
      // inspect(response.data);
      // todos.value = response.data["todos"] as List<Todo>;
      response.data["todos"].forEach((el) => {
            todos.value.add(Todo(
              id: el['id'],
              title: el['todo'],
              userId: el['userId'],
              completed: el['completed'],
            ))
          });
      isDataLoaded.value = true;
    });
    // TODO: implement onInit

    super.onInit();
  }

  void addTodo() {
    if (titleController.text.isEmpty) {
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
        completed: completed.value,
        userId: 1,
      ),
    );
    titleController.text = "";
    Get.back();
    inspect(todos);
  }

  void updateTodo(int id) async {
    final toUpdate = todos.firstWhere((item) => item.id == id);
    inspect(toUpdate);
    final index = todos.indexOf(toUpdate);
    if (index == -1) return;

    var status = !toUpdate.completed!;

    TodoRequest request = TodoRequest(completed: status);

    final response =
        await apiService.updateTodo("/todos/$id", request.toJson());
    todos[index] =
        Todo(id: toUpdate.id, title: toUpdate.title, completed: status);
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
              const Text("Status"),
              Row(
                children: <Widget>[
                  Obx(() => Expanded(
                        child: RadioListTile(
                          title: const Text("Complete"),
                          value: true,
                          groupValue: completed.value,
                          onChanged: (value) {
                            completed.value = value!;
                          },
                        ),
                      )),
                  Obx(() => Expanded(
                        child: RadioListTile(
                          title: const Text("Incomplete"),
                          value: false,
                          groupValue: completed.value,
                          onChanged: (value) {
                            completed.value = value!;
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
