import 'package:flutter/material.dart';
import '../../model/exercise.dart';
import '../../model/program.dart';
import '../../model/machine.dart';
import '/view/program/programfocus_view.dart' as programfocus_view;
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
  final TextEditingController weightEditingController = TextEditingController();

  final name ='Error';
  var currentSliderValue = 0.00;


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
          TextFormField(
            controller: weightEditingController,
            decoration: InputDecoration(label: Text('Charges')),
            keyboardType: TextInputType.number,
            validator: (formWeight) {
              if (formWeight == null || formWeight.isEmpty) {
                return 'Rentrez un poids valide';
              }
           //   formWeight = int.parse(formWeight);
              return null;
            },
          ),
          Text('Répétitions :'),
          Slider(
              value: currentSliderValue,
              max: 10,
              divisions: 10,
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                });
              },
            ),
              Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String name = nameEditingController.text;
                  String weightString = weightEditingController.text;
                  int weightInt;
                  try{
                    weightInt = int.parse(weightString);
                  }catch(e){
                    print(e);
                    weightInt = 0;
                  }
                var newMachine = Machine(id:1,name: 'ButterFly',type: 'Musculation');
                 var newExo = Exercise(
                     id: null,
                     program_id: args.program.id ?? 0,
                     name: name,
                     repeat:currentSliderValue.round(),
                     weight: weightInt, 
                     machine_id: newMachine.id ?? 0,
                   );  
                   await Exercise.insertExercise(newExo);
                Navigator.pushNamed(
                    context,
                    programfocus_view.ProgramFocusScreen.routeName,
                    arguments: programfocus_view.ScreenArguments(args.program),
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