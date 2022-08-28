import '../../model/program.dart';
import '../../model/exercise.dart';
import 'package:flutter/material.dart';
import '../../component/custom_app_bar.dart';

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ProgramFocusScreen extends StatelessWidget {
  const ProgramFocusScreen({Key? key, required this.program}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final program;
  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        title: Text(program.name),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: ExerciseList(program: program),
    );
  }
}

class ExerciseList extends StatefulWidget {
  const ExerciseList({Key? key, required this.program}) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final program;

  @override
  _ExerciseListState createState() => _ExerciseListState(program);
}

Future<List<Exercise>>? exercisesLoaded;

class _ExerciseListState extends State<ExerciseList> {
  Program program;
  _ExerciseListState(this.program);

  @override
  void initState() {
    exercisesLoaded = Future.delayed(const Duration(milliseconds: 100),
        () => Exercise.getExercisesWithProgramId(program.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
        automaticallyImplyLeading: false,
        title: const Text('Mes exercices :'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/startTraining',
                  arguments: await exercisesLoaded);
            },
            icon: Icon(Icons.play_circle_fill_outlined),
            iconSize: 30,
          ),
        ],
      ),
      body: Container(
        child: buildListExcercies(program.id),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 133, 0, 156),
        onPressed: () {
          Navigator.pushNamed(context, '/excersieform', arguments: program);
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar.buildAppBar(context),
    );
  }

  buildListExcercies(programId) {
    return FutureBuilder<List<Exercise>>(
        future: exercisesLoaded,
        builder: (context, AsyncSnapshot<List<Exercise>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return buildRow(snapshot.data![i]);
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  buildRow(Exercise exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ExpansionPanelList(
        animationDuration: const Duration(milliseconds: 500),
        dividerColor: Colors.red,
        expandedHeaderPadding: const EdgeInsets.only(bottom: 0.0),
        elevation: 1,
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        exercise.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ));
            },
            body: Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    exercise.type,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                  Exercise.buildDescription(exercise)
                ],
              ),
            ),
            isExpanded: exercise.isExpanded,
          )
        ],
        expansionCallback: (int item, bool status) {
          setState(() {
            exercise.isExpanded = !exercise.isExpanded;
          });
        },
      ),
    );
  }
}
