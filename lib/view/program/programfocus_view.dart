import '../../model/program.dart';
import '../../model/exercise.dart';
import 'package:flutter/material.dart';
import '../../component/custom_app_bar.dart';
import '/view/exercise/exercise_form.dart' as ExerciseForm;
import '../../main.dart' as MainView;

// A Widget that extracts the necessary arguments from
// the ModalRoute.
class ProgramFocusScreen extends StatelessWidget {
  const ProgramFocusScreen({Key? key}) : super(key: key);

  static const routeName = '/programfocus';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.program.name),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                MainView.MyApp.routeName,
                arguments: null,
              );
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: const ExerciseList(),
    );
  }
}

class ExerciseList extends StatefulWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    return Scaffold(
      body: Container(
        child: buildListExcercies(args.program.id),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(
            context,
            ExerciseForm.Exerciseform.routeName,
            arguments: ExerciseForm.ScreenArguments(args.program),
          );
        },
        tooltip: 'Create',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CustomBottomAppBar.buildAppBar(context),
    );
  }

  buildListExcercies(programId) {
    Future<List<Exercise>> callAsyncFetch() => Future.delayed(
        Duration(seconds: 2),
        () => Exercise.getExercisesWithProgramId(programId));
    return FutureBuilder<List<Exercise>>(
        future: callAsyncFetch(),
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
      margin: EdgeInsets.only(bottom: 10.0),
      child: ExpansionPanelList(
        animationDuration: Duration(milliseconds: 500),
        dividerColor: Colors.red,
        expandedHeaderPadding: EdgeInsets.only(bottom: 0.0),
        elevation: 1,
        children: [
          ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Text(
                        exercise.title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      exercise.isDone
                          ? IconButton(
                              icon: Icon(Icons.check_circle_outline),
                              color: Colors.green,
                              onPressed: () {
                                setState(() {
                                  exercise.isDone = !exercise.isDone;
                                });
                              },
                            )
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  exercise.isDone = !exercise.isDone;
                                });
                              },
                              icon: Icon(Icons.do_not_disturb_alt_sharp),
                              color: Colors.red,
                            )
                    ],
                  ));
            },
            body: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.type,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
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

  showMenu() {
    return;
  }
}

class ScreenArguments {
  final Program program;

  ScreenArguments(this.program);
}
