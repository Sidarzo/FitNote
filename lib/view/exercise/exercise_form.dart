import 'package:flutter/material.dart';
import '../../model/exercise.dart';
import '../../model/program.dart';
import '/view/program/programfocus_view.dart' as programfocus_view;
import '../../component/divider.dart';

class Exerciseform extends StatefulWidget {
  const Exerciseform({Key? key}) : super(key: key);

  static const routeName = '/exerciseform';

  @override
  _exerciseState createState() => _exerciseState();
}

class _exerciseState extends State<Exerciseform> {
  @override
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameEditingController = TextEditingController();

  var formInput = ['weight', 'repetition', 'serie', 'restDuration'];
  var formInputName = ['Poids', 'Répétitions', 'Séries', 'Repos'];
  var formInputValue = [0, 0, 0, 0];
  var durationValue = 0;
  var magnitude = [' kg', ' répét', ' séries', ' secs'];
  bool muscuSelected = true;
  String typeExercise = 'Muscu';

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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: nameEditingController,
                decoration: const InputDecoration(
                  label: Text('Nom de l\'exercice'),
                  icon: Icon(Icons.abc),
                ),
                validator: (formName) {
                  if (formName == null || formName.isEmpty) {
                    return 'Rentrez un nom valide';
                  }
                  return null;
                },
              ),
            ),
            Center(
              child: DropdownButton<String>(
                value: typeExercise,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    typeExercise = newValue!;
                    muscuSelected = !muscuSelected;
                  });
                },
                items: <String>['Muscu', 'Cardio']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          muscuSelected ? buildMuscuForm() : buildCardioForm()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
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
                        title: name,
                        program_id: args.program.id,
                        description: '',
                        duration: durationValue,
                        repetition: formInputValue[1],
                        restDuration: formInputValue[3],
                        serie: formInputValue[2],
                        weight: formInputValue[0],
                        type: typeExercise,
                      );
                      await Exercise.insertExercise(newExo);
                      Navigator.pushNamed(
                        context,
                        programfocus_view.ProgramFocusScreen.routeName,
                        arguments:
                            programfocus_view.ScreenArguments(args.program),
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

  buildMuscuForm() {
    List<Widget> finalInput = [];

    for (var i = 0; i < formInput.length; i++) {
      finalInput.add(Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: createDivider(formInputName[i])),
          //
          // DURATION
          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    heroTag: formInput[i] + 'Minus',
                    onPressed: () {
                      setState(() {
                        if (formInputValue[i] > 0) {
                          formInputValue[i] -= 1;
                        }
                      });
                    },
                    child:
                        const Icon(Icons.exposure_minus_1, color: Colors.black),
                    backgroundColor: Colors.white,
                  ),
                  Text(formInputValue[i].toString() + magnitude[i],
                      style: TextStyle(fontSize: 25.0)),
                  FloatingActionButton(
                    heroTag: formInput[i] + 'Plus',
                    onPressed: () {
                      setState(() {
                        formInputValue[i] += 1;
                      });
                    },
                    child: const Icon(
                      Icons.exposure_plus_1,
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
    }
    return Column(children: finalInput);
  }

  buildCardioForm() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: createDivider('Duration')),
        //
        // DURATION
        //
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton(
                  heroTag: 'durationMinus',
                  onPressed: () {
                    setState(() {
                      if (durationValue > 0) {
                        durationValue -= 1;
                      }
                    });
                  },
                  child:
                      const Icon(Icons.exposure_minus_1, color: Colors.black),
                  backgroundColor: Colors.white,
                ),
                Text(durationValue.toString(),
                    style: TextStyle(fontSize: 25.0)),
                FloatingActionButton(
                  heroTag: 'durationPlus',
                  onPressed: () {
                    setState(() {
                      durationValue += 1;
                    });
                  },
                  child: const Icon(
                    Icons.exposure_plus_1,
                    color: Colors.black,
                  ),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ScreenArguments {
  final Program program;

  ScreenArguments(this.program);
}
