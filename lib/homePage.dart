import 'package:flutter/material.dart';
import 'gamePage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GamePage())
          )
        },

      ),
      body: const Center(
        child: Text(
          "Test",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32
          )
        ),
      )
    );
  }
}