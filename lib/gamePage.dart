import 'dart:math';

import 'package:flutter/material.dart';
import 'factorization.dart';

class GamePage extends StatefulWidget{
  const GamePage({super.key, required this.difficulty});

  final int difficulty;

  @override
  _GamePage createState() => _GamePage();
}

class _GamePage extends State<GamePage>{

  late FocusNode focusNode;
  final _formKey = GlobalKey<FormState>();
  // The number and its prime divisors
  int n = 2;
  Map<int, int>primeDivisors = {2: 1};
  // Whether the input value is accepted
  bool? accepted;
  Color underlineColor = Colors.black;

  // Get next random number
  void randomNumber(){
    setState(() {
      n = Random().nextInt((pow(10, widget.difficulty) - 2).toInt()) + 2;
      primeDivisors = getPrimeDivisor(n);
    });
    print(n);
    print(primeDivisors.toString());
  }

  // Do division to current number
  void division(int v){
    setState(() {
      n ~/= v;
    });
    assert(primeDivisors[v] != null && primeDivisors[v]! > 0);
    primeDivisors[v] = primeDivisors[v]! - 1;
    print(n);
    print(primeDivisors.toString());
  }

  void onDivisorSubmitted(){
    if (_formKey.currentState!.validate()) {
      setState(() {
        accepted = true;
      });
    } else{
      setState(() {
        accepted = false;
      });
    }
    if (n == 1) {
      randomNumber();
    }
    focusNode.requestFocus();
    setState(() {
      underlineColor = (accepted == null ? Colors.white : accepted! ? Colors.green : Colors.red);
    });
  }

 @override
 void initState(){
    focusNode = FocusNode();
    super.initState();
 }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
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
                        autofocus: true,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: underlineColor)),
                          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: underlineColor)),
                          border: UnderlineInputBorder(borderSide: BorderSide(color: underlineColor)),
                        ),
                        validator: (value) {
                          if(isPrime(n) && (value == null || value.isEmpty || int.tryParse(value) == 0)) {
                            division(n);
                            return null;
                          } else if(value == null){
                            return "Please enter a number";
                          }
                          int? v = int.tryParse(value);
                          if(v == null || v <= 1){
                            return "Please enter a natural number greater than 1";
                          } else if (n % v != 0 || !isPrime(v)){
                            return "Not a prime divisor of current number";
                          }
                          division(v);
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          onDivisorSubmitted();
                        }
                      ),
                    ),
                    ElevatedButton(
                      onPressed: onDivisorSubmitted,
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