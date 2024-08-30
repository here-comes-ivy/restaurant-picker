import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'spinner_spinnerBuilder.dart';
import '../../utils/responsiveSize.dart';


class ModalBottomSheetContent extends StatefulWidget {
  @override
  State<ModalBottomSheetContent> createState() => _ModalBottomSheetContentState();

  static void showCustomModalBottomSheet(BuildContext context) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.1, // 初始大小
          minChildSize: 0.1,     // 最小大小
          maxChildSize: 0.8, 
          //expand: false,// 最大大小
          builder: (BuildContext context, ScrollController scrollController) {
            return ModalBottomSheetContent();
          },
        );
      },
    );
  }
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {

  final GlobalKey<SpinnerState> spinnerKey = GlobalKey<SpinnerState>();


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spinner(key: spinnerKey),
          Card(
            elevation: 30.0,
            child: FilledButton(
            child: Text(
              'Try Again',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            onPressed: () {
              setState(() {
                spinnerKey.currentState?.spinAgain();
              }
              );
            },
                    ),
          ),
        ],
      ),
    );
  }
}
