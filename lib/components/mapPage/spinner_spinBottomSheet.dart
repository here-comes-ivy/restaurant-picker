import 'package:flutter/material.dart';
import 'spinner_spinnerBuilder.dart';
import 'package:restaurant_picker/utils/smallWidgetBuilder.dart';

class SpinnerBottomSheet extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> dataFuture;

  const SpinnerBottomSheet({
    super.key,
    required this.dataFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomSheetHandler(),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: dataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return SpinnerBuilder(data: snapshot.data!);
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context, Future<List<Map<String, dynamic>>> dataFuture) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SpinnerBottomSheet(dataFuture: dataFuture);
      },
    );
  }
}