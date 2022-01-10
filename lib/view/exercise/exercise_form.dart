import 'package:flutter/material.dart';
import '../../model/exercise.dart';
import '../../model/program.dart';
import '/view/program/programfocus_view.dart' as Programfocus;


import '../../main.dart' as MainView;


class Exerciseform extends StatefulWidget {
  const Exerciseform({ Key? key }) : super(key: key);
  
  static const routeName = '/exerciseform';

  @override
  _exerciseState createState() => _exerciseState();
}

class _exerciseState extends State<Exerciseform> {
  @override
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameEditingController = TextEditingController();
  final name ='Error';


  Widget build(BuildContext context) {
   final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      appBar: AppBar(
          title: const Text('FitNote'),
          centerTitle: true,
          
        ),
      body: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: nameEditingController,
            decoration: InputDecoration(label: Text('Nom de l\'exercice')),
            validator: (formName) {
              if (formName == null || formName.isEmpty) {
                return 'Rentrez un nom valide';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String name = nameEditingController.text;
                 var newExo = Exercise(
                     id: null,
                     program_id: args.program.id ?? 0,
                     name: name,
                     repeat:1,
                     weight: 1, 
                   );  
                   await Exercise.insertExercise(newExo);
                Navigator.pushNamed(
                    context,
                    Programfocus.ProgramFocusScreen.routeName,
                    arguments: Programfocus.ScreenArguments(args.program),
                  );   
                }
              },
              child: const Text('Créer l\'exercice'),
            ),
          ),
          ),
        ],
      ),
    ),
    );
  }
  
}

class ScreenArguments {
  final Program program;

  ScreenArguments(this.program);

}