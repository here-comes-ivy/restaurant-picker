import 'package:flutter/material.dart';
import 'favoriteitems.dart';
import '../components/editAndDeleteDialog.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, dynamic>> itemList = [
    {'name': '巴黎', 'places': ['艾菲爾鐵塔', '羅浮宮', '凱旋門']},
    {'name': '東京', 'places': ['東京鐵塔', '淺草寺', '明治神宮']},
    {'name': '紐約', 'places': ['自由女神像', '中央公園', '帝國大廈']},
  ];

  void _addNewList() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddListDialog(
        onAdd: (String newListName) {
          setState(() {
            itemList.add({'name': newListName, 'places': []});
          });
        },
      ),
    );
  }

  void _editList(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => EditListDialog(
        initialName: itemList[index]['name'],
        onEdit: (String updatedListName) {
          setState(() {
            itemList[index]['name'] = updatedListName;
          });
        },
      ),
    );
  }

  void _deleteList(int index) {
    setState(() {
      itemList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(itemList[index]['name']),
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
                    itemName: itemList[index]['name'],
                    onDelete: () {
                      setState(() {
                        itemList.removeAt(index);
                      });
                    },
                  ),
                );
              } else {
                _editList(index);
                return false;
              }
            },
            child: Card(
              child: ListTile(
                leading: Icon(Icons.list),
                title: Text(itemList[index]['name']),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListDetailPage(list: itemList[index]),
                    ),
                  );
                },
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
}
