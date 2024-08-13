import 'package:flutter/material.dart';
import '../components/spinner.dart';

class SpinButton extends StatelessWidget {
  const SpinButton({Key? key}) : super(key: key);

  Widget button(BuildContext context, Color color, String text, {VoidCallback? addonPressed}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FilledButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty .all(color),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Spinner()),
            );
            if (addonPressed != null) {
              addonPressed();
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 這裡應該返回使用 button 方法創建的 widget
    // 例如：
    return button(context, Colors.yellow, "Surprise me!");
  }
}