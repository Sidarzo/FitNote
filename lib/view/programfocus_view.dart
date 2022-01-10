import '../model/program.dart';
import '../model/exercice.dart';
import 'package:flutter/material.dart';



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
      body: const ExerciceList(),
    );
  }
}

class ExerciceList extends StatefulWidget {
  const ExerciceList({ Key? key }) : super(key: key);

  @override
  _ExerciceListState createState() => _ExerciceListState();
}

class _ExerciceListState extends State<ExerciceList> {
  
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
                //    Navigator.push(
                //    context,
                //   MaterialPageRoute(builder: (context) => formProgramView.programform()),
                // );
                },
                tooltip: 'Create',
                child: const Icon(Icons.add),
              ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.blue,
            child: IconTheme(
            data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
            child: Row(
              children: <Widget>[
                IconButton(     
                  icon: const Icon(Icons.crop),
                  onPressed: () {
                    var newExercice =  Exercice(id: null, program_id: 10, name: 'Exo 1', repeat: 4, weight: 5);
                    var newExercice2 =  Exercice(id: null, program_id: 10, name: 'Exo 2', repeat: 6, weight: 15);
                    Exercice.insertExercice(newExercice);
                    Exercice.insertExercice(newExercice2);
              },
                ),
              ],
            ),
          ),
        ),
    );
  }


  buildListExcercies(programId) {

    Future<List<Exercice>> callAsyncFetch() => Future.delayed(Duration(seconds: 2), () => Exercice.getExercicesWithProgramId(programId));
    return FutureBuilder<List<Exercice>>(
      future: callAsyncFetch(),
      builder: (context, AsyncSnapshot<List<Exercice>> snapshot) {
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
  buildRow(Exercice exercice) {
    index++;
    exercice.name;
    return
    ListTile(
       title: 
        Text(exercice.name, style: const TextStyle(
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
          leading: Text('Répetition : ' + exercice.repeat.toString() + ' Charges : ' + exercice.weight.toString()),
          trailing: IconButton(onPressed: (){
            
            Program.deleteProgram(exercice.id ?? 0);
            setState(() {});
          }, icon: const Icon(Icons.delete)),
    );
  }
}

class ScreenArguments {
  final Program program;

  ScreenArguments(this.program);

}