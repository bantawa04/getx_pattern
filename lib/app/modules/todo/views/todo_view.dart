import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  TodoView({Key? key}) : super(key: key);
  @override
  final controller = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
      ),
      body: Obx(
        () => !controller.isDataLoaded.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  var todo = controller.todos.value[index];
                  return GestureDetector(
                    onDoubleTap: () => controller.updateTodo(todo.id!),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 8,
                        top: 16,
                        right: 16,
                        bottom: 0,
                      ),
                      child: Dismissible(
                        key: ValueKey(controller.todos[index]),
                        background: Container(
                          color: Theme.of(context).errorColor.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 8),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) {
                          return Get.dialog(
                            AlertDialog(
                              title: const Text("Delete Todo"),
                              content: const Text(
                                  "Are you sure you want to delete ?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Get.back(result: true),
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () => Get.back(result: false),
                                  child: const Text("No"),
                                ),
                              ],
                            ),
                          );
                        },
                        onDismissed: (direction) {
                          controller.deleteTodo(todo.id!);
                        },
                        child: ListTile(
                          leading: Icon(
                            color: todo.completed! ? Colors.green : Colors.red,
                            todo.completed! ? Icons.check_circle : Icons.close,
                          ),
                          title: Text(todo.title!),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: controller.todos.value.length,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.showModelForm();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
