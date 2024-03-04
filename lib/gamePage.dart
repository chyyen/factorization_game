import 'dart:math';

import 'package:flutter/material.dart';
import 'factorization.dart';

class GamePage extends StatefulWidget{
  const GamePage({super.key});

  @override
  _GamePage createState() => _GamePage();
}

class _GamePage extends State<GamePage>{

  final _formKey = GlobalKey<FormState>();

  int n = 2;
  Map<int, int>primeDivisors = {2: 1};

  void randomNumber(){
    setState(() {
      n = Random().nextInt(300) + 2;
      primeDivisors = getPrimeDivisor(n);
    });
    print(n);
    print(primeDivisors.toString());
  }

  void division(int v){
    setState(() {
      n ~/= v;
    });
    assert(primeDivisors[v] != null && primeDivisors[v]! > 0);
    primeDivisors[v] = primeDivisors[v]! - 1;
    print(n);
    print(primeDivisors.toString());
  }

  @override
  Widget build(BuildContext context){
    return (
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
        body: Center(
          child: Column(
            children: [
              Text(n.toString()),
              //Text(primeDivisors.toString()),
              TextButton(
                onPressed: randomNumber,
                child: const Text("Next number")
              ),
               Form(
                key: _formKey,
                child: Row (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        validator: (value) {
                          if(value == null){
                            return "Please enter a number";
                          }
                          int? v = int.tryParse(value);
                          if(v == null || v <= 1){
                            return "Please enter a natural number greater than 1";
                          }
                          if(n % v != 0 || !isPrime(v)){
                            return "Not a prime divisor of current number";
                          }
                          division(v);
                          return null;
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Good job!')),
                          );
                        }
                        if(n == 1){
                          randomNumber();
                        }
                      },
                      child: const Text("Factorize!")
                    )
                  ],
                )
              ),
            ],
          ),
        )
      )
    );
  }
}