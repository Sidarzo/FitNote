import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/program/programform_view_model.dart';

class Programform extends StatefulWidget {
  const Programform({Key? key}) : super(key: key);

  @override
  _programformState createState() => _programformState();
}

class _programformState extends State<Programform> {
  late ProgramFormViewModel _pvm;

  @override
  void initState() {
    _pvm = Provider.of<ProgramFormViewModel>(context, listen: false);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameEditingController = TextEditingController();
  final name = 'Error';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
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
                decoration:
                    const InputDecoration(label: Text('Nom du programme')),
                validator: (formName) {
                  if (formName == null || formName.isEmpty) {
                    return 'Rentrez un nom valide';
                  }
                  return null;
                },
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
                      _pvm.createProgramButtonOnClickCommand(name);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/dashboard', (route) => false);
                    }
                  },
                  child: const Text('Créer le programme'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
