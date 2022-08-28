import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/training/training_view_model.dart';

class TrainingView extends StatefulWidget {
  const TrainingView({Key? key, required this.exercises}) : super(key: key);

  final exercises;
  @override
  _TrainingViewState createState() => _TrainingViewState(exercises);
}

class _TrainingViewState extends State<TrainingView> {
  final exercises;

  _TrainingViewState(this.exercises);
  late TrainingViewModel _tvm;

  @override
  int index = 0;
  int valueTimer = 0;
  bool timerStarted = false;
  var timer;
  

  void initState() {
    _tvm = Provider.of<TrainingViewModel>(context, listen: false);
    valueTimer = exercises[0].restDuration ?? 1.00;
    super.initState();
  }
  

  Widget build(BuildContext context) {
    
    int restDuration = exercises[index].restDuration;

    if(restDuration == 0){
      restDuration = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session training'),
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tvm.buildExercise(index, exercises),
              ],
          ),
          Row(children: [
            Container(height: 40,)
          ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 7,
                        value: (valueTimer.toDouble() / 
                                restDuration)
                            .toDouble(),
                        valueColor: const AlwaysStoppedAnimation(Colors.black),
                        backgroundColor: const Color.fromARGB(255, 133, 0, 156),
                      ),
                      Center(
                        child: Text(
                          '$valueTimer',
                          style: const TextStyle(fontSize: 25),
                        ),
                      )
                    ],
                  )
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: ()=>setState(() => valueTimer--), icon: const Icon(Icons.remove)),
              !timerStarted
                  ? ElevatedButton(
                      onPressed: (()=>startTimer()),
                      child: const Icon(Icons.play_circle),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 133, 0, 156))),
                    )
                  : ElevatedButton(
                      onPressed: (() => pauseTimer()),
                      child: const Icon(Icons.pause),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 133, 0, 156))),
                    ),
              ElevatedButton(
                onPressed: (() => reStartTimer()),
                child: const Icon(Icons.replay_outlined),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 133, 0, 156))),
              ),
              IconButton(onPressed: (() => setState(() => valueTimer++)), icon: Icon(Icons.add))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Terminé : ',style: TextStyle(fontSize: 25)),
              Checkbox(value: exercises[index].isDone, onChanged: (value){
                setState(() {
                  exercises[index].isDone = value!;
                });
             } )
          ],)
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 32, 32, 32),
        child: Row(children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (index > 0) {
                  index--;
                  valueTimer = exercises[index].restDuration ?? 1.00;
                }
              });
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            iconSize: 30,
          ),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 133, 0, 156))),
            onPressed: () {
                final snackBar = SnackBar(
                content: const Text('Êtes-vous sûr de finir cette session ?'),
                action: SnackBarAction(
                  label: 'Oui',
                  onPressed: () {
                    _tvm.createSessionButtonOnClickCommand(exercises[index].program_id);
                    Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
                  },
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Finir la session'),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              setState(() {
                if (index < exercises.length - 1) {
                  index++;
                  valueTimer = exercises[index].restDuration ?? 1;
                }
              });
            },
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            iconSize: 30,
          )
        ]),
      ),
    );
  }


  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (_) {
    if (valueTimer >= 1) {
      setState(() {
      valueTimer--;
      timerStarted = true;
      });
    } 
      else {
        timer.cancel();
        valueTimer = exercises[index].restDuration;
        setState(() => timerStarted = false);
    }
    });
  }

  void pauseTimer(){
    timer?.cancel();
    setState(() {
      timerStarted = false;
    });
  }

  void stopTimer(){

  }

  void reStartTimer(){
    setState(() {
      timerStarted = false;
      valueTimer = exercises[index].restDuration;
      timer?.cancel();
    });
  }
}
