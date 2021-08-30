import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';

class TodoListHeader extends StatelessWidget {
  const TodoListHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Reminders",
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400),
        ),
        Spacer(),
      ],
    );
  }
}

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (_, __) {
          return const YMargin(2);
        },
        itemCount: 3,
        itemBuilder: (ctx, idx) {
          return Card(
            elevation: 0,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
                tileColor: Colors.yellow[100],
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 13,
                  color: Colors.black,
                ),
                leading: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.amber[100],
                  child: Icon(
                    Icons.notifications,
                    size: 15,
                    color: Colors.orange[400],
                  ),
                ),
                subtitle: Text("Urgent"),
                title: Text("Rent is due in 3 days")),
          );
        });
  }
}
