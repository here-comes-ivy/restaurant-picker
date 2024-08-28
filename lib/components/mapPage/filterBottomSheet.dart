import 'package:flutter/material.dart';
import 'filterBottomSheetContent.dart';

class SearchBottomSheet extends StatelessWidget {
  const SearchBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        //color: Theme.of(context).scaffoldBackgroundColor,

        //WidgetStateProperty.all( Theme.of(context).colorScheme.surface.withOpacity(0.8)),

        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            child: Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: FilterPageContent(),
          ),
        ],
      ),
    );
  }
}