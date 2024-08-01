
import 'package:flutter/material.dart';

class BottomSheet extends StatelessWidget {
      const BottomSheet({super.key});
    
      @override
      Widget build(BuildContext context) {
        return Center(
          child: ElevatedButton(
            child: const Text('showModalBottomSheet'),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('Welcome to Modal Bottom Sheet'),
                          ElevatedButton(
                            child: const Text('Close BottomSheet'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      }
    }