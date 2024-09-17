import 'package:flutter/material.dart';
import 'spinner_spinBottomSheet.dart';

class SpinButton extends StatelessWidget {

  final Future<List<Map<String, dynamic>>> dataFuture;

  const SpinButton({
    super.key,
    required this.dataFuture,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.05,
      child: FilledButton.tonal(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(20.0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Colors.grey),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.surface.withOpacity(0.8)),
        ),
        onPressed: () {
          SpinnerBottomSheet.show(context, dataFuture);
        },
        child: const Text(
          'Surprise me!',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
