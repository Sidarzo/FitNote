import '../../model/program.dart';
import '../../model/exercise.dart';
import 'package:flutter/material.dart';
import '../../component/custom_app_bar.dart';
import '/view/exercise/exercise_form.dart' as ExerciseForm;




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
      ),
      body: const ExerciseList(),
    );
  }
}

class ExerciseList extends StatefulWidget {
  const ExerciseList({ Key? key }) : super(key: key);

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
        floatingActionButton: 
             FloatingActionButton(
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
            bottomNavigationBar: CustomBottomAppBar.buildAppBar(),
    );
  }


  buildListExcercies(programId) {

    Future<List<Exercise>> callAsyncFetch() => Future.delayed(Duration(seconds: 2), () => Exercise.getExercisesWithProgramId(programId));
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
      }
    );
  }


   var index = 0;
  buildRow(Exercise exercise) {
    index++;
    exercise.name;
    return
    ListTile(
       title: 
        Text(exercise.name, style: const TextStyle(
          // color:  Color(0xFF043b90),
          // fontWeight: FontWeight.bold,
            ),
          ),
         // leading: Text('Programme n°' + (index).toString()),
          onTap: (){
            //  Navigator.pushNamed(
            //     context,
            //     Programfocus.ProgramFocusScreen.routeName,
            //     arguments: Programfocus.ScreenArguments(program,
            //     ),
            //   );
          },
          leading: Text('Répetition : ' + exercise.repeat.toString() + ' Charges : ' + exercise.weight.toString()),
          trailing: IconButton(onPressed: (){
            
            Program.deleteProgram(exercise.id ?? 0);
            setState(() {});
          }, icon: const Icon(Icons.delete)),
    );
  }
}

class ScreenArguments {
  final Program program;

  ScreenArguments(this.program);

}