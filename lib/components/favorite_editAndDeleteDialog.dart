
import 'package:flutter/material.dart';

class DeleteBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20.0),
      child: Icon(Icons.delete, color: Colors.white),
    );
  }
}

class EditBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 20.0),
      child: Icon(Icons.edit, color: Colors.white),
    );
  }
}


class AddListDialog extends StatelessWidget {
  final Function(String) onAdd;

  AddListDialog({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    String newListName = '';
    return AlertDialog(
      title: Text('Add New List'),
      content: TextField(
        onChanged: (value) {
          newListName = value;
        },
        decoration: InputDecoration(hintText: "New List Name"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (newListName.isNotEmpty) {
              onAdd(newListName);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class EditListDialog extends StatelessWidget {
  final String initialName;
  final Function(String) onEdit;

  EditListDialog({required this.initialName, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    String updatedListName = initialName;
    return AlertDialog(
      title: Text('Edit List Name'),
      content: TextField(
        onChanged: (value) {
          updatedListName = value;
        },
        decoration: InputDecoration(hintText: "New List Name"),
        controller: TextEditingController(text: updatedListName),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (updatedListName.isNotEmpty) {
              onEdit(updatedListName);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class DeleteConfirmationDialog extends StatelessWidget {
  final String itemName;
  final VoidCallback onDelete;

  DeleteConfirmationDialog({required this.itemName, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure you want to delete $itemName?"),
      actions: <Widget>[
        ElevatedButton(
          child: Text("Cancel", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ElevatedButton(
          child: Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            onDelete();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}

