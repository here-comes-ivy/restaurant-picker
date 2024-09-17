import 'package:flutter/material.dart';
import 'package:restaurant_picker/services/firestoreService.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(237, 58, 39, 1),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      child: const Icon(Icons.delete, color: Colors.white),
    );
  }
}

class EditWidget extends StatelessWidget {
  const EditWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20.0),
      child: const Icon(Icons.edit, color: Colors.white),
    );
  }
}

class DeleteFavoriteConfirmationDialog extends StatelessWidget {
  FirestoreService firestoreService = FirestoreService();

  final String itemName;
  final VoidCallback onDelete;
  String restaurantID;
  String loggedinUserID;

  DeleteFavoriteConfirmationDialog(
      {super.key, required this.itemName,
      required this.onDelete,
      required this.restaurantID,
      required this.loggedinUserID});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure you want to delete $itemName?"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Cancel",),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ElevatedButton(
          child: const Text("Delete",
              style: TextStyle(color: Color.fromRGBO(237, 58, 39, 1))),
          onPressed: () async {
            onDelete();
            Navigator.of(context).pop(true);
            await firestoreService.updateFavoriteStatus(
              context,
              restaurantID: restaurantID,
              savedAsFavorite: false,
            );
          },
        ),
      ],
    );
  }
}

class AddListDialog extends StatelessWidget {
  final Function(String) onAdd;

  const AddListDialog({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    String newListName = '';
    return AlertDialog(
      title: const Text('Add New List'),
      content: TextField(
        onChanged: (value) {
          newListName = value;
        },
        decoration: const InputDecoration(hintText: "New List Name"),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Confirm'),
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

  const EditListDialog({super.key, required this.initialName, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    String updatedListName = initialName;
    return AlertDialog(
      title: const Text('Edit List Name'),
      content: TextField(
        onChanged: (value) {
          updatedListName = value;
        },
        decoration: const InputDecoration(hintText: "New List Name"),
        controller: TextEditingController(text: updatedListName),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Confirm'),
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

  const DeleteConfirmationDialog({super.key, required this.itemName, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Are you sure you want to delete $itemName?"),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Cancel", style: TextStyle(color: Colors.black)),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        ElevatedButton(
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
          onPressed: () {
            onDelete();
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }
}
