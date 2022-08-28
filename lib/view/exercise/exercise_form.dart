import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/exercise.dart';
import '../../component/divider.dart';
import '../../model/program.dart';
import '../../view_model/exercise/exerciseform_view_model.dart';

class Exerciseform extends StatefulWidget {
  const Exerciseform({Key? key, required this.program}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final program;

  @override
  _exerciseState createState() => _exerciseState(program);
}

class _exerciseState extends State<Exerciseform> {
  _exerciseState(this.program);
  final Program program;

  late ExerciseFormViewModel _efvm;

  @override
  void initState() {
    _efvm = Provider.of<ExerciseFormViewModel>(context, listen: false);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameEditingController = TextEditingController();

  var formInput = ['weight', 'repetition', 'serie', 'restDuration'];
  var formInputName = ['Poids', 'Répétitions', 'Séries', 'Repos'];
  var formInputValue = [0, 0, 0, 0];
  var durationValue = 0;
  var magnitude = [' kg', ' répét', ' séries', ' secs'];
  bool muscuSelected = true;
  String typeExercise = 'Muscu';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
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
                  color: const Color.fromARGB(255, 32, 32, 32),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (typeExercise != newValue) {
                      muscuSelected = !muscuSelected;
                    }
                    typeExercise = newValue!;
                  });
                },
                items: <String>['Muscu', 'Cardio']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 32, 32, 32),
                      ),
                    ),
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
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 133, 0, 156))),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String name = nameEditingController.text;

                      var newExo = Exercise(
                        id: null,
                        title: name,
                        program_id: program.id,
                        description: '',
                        duration: durationValue,
                        repetition: formInputValue[1],
                        restDuration: formInputValue[3],
                        serie: formInputValue[2],
                        weight: formInputValue[0],
                        type: typeExercise,
                      );

                      _efvm.createExerciseButtonOnClickCommand(newExo);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/focusprogram', (route) => false,
                          arguments: program);
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
                      style: const TextStyle(fontSize: 25.0)),
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
                Text(durationValue.toString() + ' mins',
                    style: const TextStyle(fontSize: 25.0)),
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
