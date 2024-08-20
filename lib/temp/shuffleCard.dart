
import 'package:flutter/material.dart';
import 'package:restaurant_picker/utils/colorSetting.dart';
import '../components/map_spinner.dart';
import '/utils/responsiveSize.dart';

class ShuffleCard extends StatefulWidget {
  const ShuffleCard({super.key});

  @override
  State<ShuffleCard> createState() => _ShuffleCardState();
}

class _ShuffleCardState extends State<ShuffleCard> {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(150),
      //color: Colors.transparent,
      child: Stack(
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text('Not sure what to eat?'),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll <Color>(appColors.second),
                        foregroundColor:WidgetStatePropertyAll <Color>(Colors.white),
                      ),
                      onPressed: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Spinner()),
                         */
                        showDialog(
                          context: context,
                          builder: (BuildContext){ 
                            return Dialog(
                              child: SizedBox(
                                  width: ResponsiveSize.spinDialogWidth(context),
                                  height: ResponsiveSize.spinDialogHeight(context),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("Let's have ... "),
                                      const Expanded(
                                        child: Spinner(),
                                       ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          FloatingActionButton(
                                            onPressed: (){},
                                            child: const Icon(Icons.refresh),
                                          ),
                                          FloatingActionButton(
                                            onPressed: (){},
                                            child: const Icon(Icons.check),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                              ), 
                            );
                          },
                        );
                      },
                      child: const Text("Let's roll!"),
                    ),
                  ],
                ),
              ),
            ],
          ),
      
    );
  }
}
