import 'package:flutter/material.dart';
import 'favoriteitems.dart';
import '../components/editAndDeleteDialog.dart';
import '../components/reusableCard.dart';

class SavedItem {
  final String title;
  List<String> contents = [];
  SavedItem(this.title, this.contents);
}

List<SavedItem> savedItems = [
  SavedItem(
    'Taipei',
    ['10001', '10002', '10003', '10004'],
  ),
  SavedItem(
    'Tokyo',
    ['20001', '20002', '20003'],
  ),
  SavedItem(
    'New York',
    ['30001', '30002', '30003', '30004'],
  ),
];

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void _addNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddListDialog(
        onAdd: (String newListName) {
          setState(() {
            savedItems.add(SavedItem(newListName, []));
          });
        },
      ),
    );
  }

  void _editList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditListDialog(
        initialName: savedItems[index].title,
        onEdit: (String updatedListName) {
          setState(() {
            savedItems.add(SavedItem(updatedListName, []));
          });
        },
      ),
    );
  }

  void _deleteList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => DeleteConfirmationDialog(
        itemName: savedItems[index].title,
        onDelete: () {
          setState(() {
            savedItems.removeAt(index);
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: savedItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(savedItems[index].title),
            secondaryBackground: DeleteBackground(),
            background: EditBackground(),
            dismissThresholds: {
              DismissDirection.endToStart: 0.2,
              DismissDirection.startToEnd: 0.2,
            },
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.endToStart) {
                return await showDialog(
                  context: context,
                  builder: (BuildContext context) => DeleteConfirmationDialog(
                    itemName: savedItems[index].title,
                    onDelete: () {
                      setState(() {
                        savedItems.removeAt(index);
                      });
                    },
                  ),
                );
              } else {
                _editList(index);
                return false;
              }
            },
            child: RestaurantCard(
              cardChild: ExpansionTile(
                title: Text(
                  savedItems[index].title,
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
                children: <Widget>[
                  Column(
                    children: _buildExpandableContent(savedItems[index]),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addNewList,
      ),
    );
  }

  List<Widget> _buildExpandableContent(SavedItem item) {
    return item.contents.map((content) {
      return RestaurantCard(
        customPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        customMargin: EdgeInsets.zero,
        cardChild: ListTile(
          title: Text(
            content,
            style: TextStyle(fontSize: 18.0),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // 实现编辑单个内容的逻辑
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    item.contents.remove(content);
                  });
                },
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}
