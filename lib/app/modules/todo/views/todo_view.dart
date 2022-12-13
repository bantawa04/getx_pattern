import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/todo_controller.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemBuilder: (ctx, index) {
            return GestureDetector(
              onDoubleTap: () =>
                  controller.updateTodo(controller.todos[index].id),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  top: 16,
                  right: 16,
                  bottom: 0,
                ),
                child: Dismissible(
                  key: ValueKey(controller.todos[index].id),
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
                        content:
                            const Text("Are you sure you want to delete ?"),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(result: false),
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () => Get.back(result: true),
                            child: const Text("No"),
                          ),
                        ],
                      ),
                    );
                  },
                  onDismissed: (direction) {
                    controller.deleteTodo(controller.todos[index].id);
                  },
                  child: ListTile(
                    leading: Icon(
                      color: controller.todos[index].status
                          ? Colors.green
                          : Colors.red,
                      controller.todos[index].status
                          ? Icons.check_circle
                          : Icons.close,
                    ),
                    title: Text(controller.todos[index].title),
                    subtitle: Text(controller.todos[index].description!),
                  ),
                ),
              ),
            );
          },
          itemCount: controller.todos.length,
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
