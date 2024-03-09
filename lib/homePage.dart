import 'package:flutter/material.dart';
import 'gamePage.dart';
import 'difficultySelect.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int power = 2;

  void changeDifficulty(int value){
    setState(() {
      power = value;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              "Test",
              style: TextStyle(
                color: Colors.black,
                fontSize: 32
              )
            ),
            FloatingActionButton.large(
              heroTag: "game button",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GamePage(difficulty: power))
                );
              },
            ),
            FloatingActionButton.large(
              heroTag: "difficulty select button",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DifficultySelector(difficulty: power, changeDifficulty: changeDifficulty,))
                );
              },
            ),
          ],
        ),
      )
    );
  }
}