import 'package:applista/Models/todo.dart';
import 'package:applista/widgets/todo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:applista/pages/listametal.dart';

class TodoListItem extends StatelessWidget {
   TodoListItem({Key? key, required this.todo, required this.onDelete, }) : super(key: key);

  final Todo todo;
  final Function(Todo) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Slidable(
        actionExtentRatio: 0.25,
        actionPane: const SlidableDrawerActionPane(),

        secondaryActions: [
          IconSlideAction(
            caption: 'Deletar',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              onDelete(todo);
            },
          )
        ],
        child: Container (
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: Colors.grey[700],
          ),
          padding: const EdgeInsets.all(16),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('dd/MMMM/yyyy - HH:mm').format(todo.dateTime),
                style:
                TextStyle(
                  fontSize: 12,
                ),),
              Text(todo.title ,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
                Text(todo.preco,
                  style: TextStyle(
                    fontSize: 16,
                  )
                ),
            ],
          ) ,
        ),

      ),
    );
  }
}

/*implementar


 */