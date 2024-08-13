import 'package:flutter/material.dart';

class ListDetailPage extends StatelessWidget {
  final Map<String, dynamic> list;

  ListDetailPage({required this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(list['name']),
      ),
      body: ListView.builder(
        itemCount: list['places'].length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(list['places'][index]),
            ),
          );
        },
      ),
    );
  }
}