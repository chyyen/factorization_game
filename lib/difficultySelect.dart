import 'dart:math';
import 'package:flutter/material.dart';

class DifficultySelector extends StatefulWidget{
  const DifficultySelector({super.key, required this.difficulty, required this.changeDifficulty});

  final int difficulty;
  final changeDifficulty;

  @override
  _DifficultySelector createState() => _DifficultySelector();
}

class _DifficultySelector extends State<DifficultySelector>{

 int diff = 0;

  @override
  void initState(){
    diff = widget.difficulty;
    super.initState();
  }

  @override
  Widget build(BuildContext contextk){
    return(
      Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            bool? result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Go Back to home page?"),
                    actions: [
                      TextButton(
                          onPressed: () => {
                            Navigator.pop(context, false)
                          },
                          child: const Text("No")
                      ),
                      TextButton(
                          onPressed: () => {
                            Navigator.pop(context, true)
                          },
                          child: const Text("Yes")
                      )
                    ],
                  );
                }
            );
            if(result is bool && result){
              Navigator.pop(context);
            }
          },
        ),
        body: Slider(
          value: diff.toDouble(),
          max: 9,
          label: diff.toString(),
          divisions: 9,
          onChanged: (double value) {
            setState(() {
              diff = value.round();
            });
            widget.changeDifficulty(diff);
          },
        ),
      )
    );
  }
}