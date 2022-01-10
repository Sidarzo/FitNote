import 'package:flutter/material.dart';
import '../model/program.dart';
import '../main.dart' as MainView;


class Programform extends StatefulWidget {
  const Programform({ Key? key }) : super(key: key);
  
  static const routeName = '/programform';

  @override
  _programformState createState() => _programformState();
}

class _programformState extends State<Programform> {
  @override
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameEditingController = TextEditingController();
  final name ='Error';


  Widget build(BuildContext context) {

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
            decoration: InputDecoration(label: Text('Nom du programme')),
            validator: (formName) {
              if (formName == null || formName.isEmpty) {
                return 'Rentrez un nom valide';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String name = nameEditingController.text;
                 var newProgram = Program(
                     id: null,
                     name: name,
                   );  
                   await Program.insertProgram(newProgram);
                   
                }
                  Navigator.pushNamed(
                  context,
                  MainView.MyApp.routeName,
                  arguments: null,
              );
              },
              child: const Text('Créer le programme'),
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