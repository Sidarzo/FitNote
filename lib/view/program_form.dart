import 'package:flutter/material.dart';
import '../model/program.dart';

class programform extends StatelessWidget {
 programform({ Key? key, this.email }) : super(key: key);

  @override
  
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameEditingController = TextEditingController();
  final email;


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
                Navigator.pop(context);
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


