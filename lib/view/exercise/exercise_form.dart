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
  var value = 0;
  var magnitude = [' kg', ' répét', ' séries', ' mins'];

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
            Expanded(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[buildMuscuForm()],
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
                        duration: 0,
                        repetition: formInputValue[1],
                        restDuration: formInputValue[3],
                        serie: formInputValue[2],
                        weight: formInputValue[0],
                        type: 'muscu',
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
                        value += 1;
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
}

class ScreenArguments {
  final Program program;

  ScreenArguments(this.program);
}
