import 'package:flutter/material.dart';
import '../model/program.dart';
import '/view/program_form.dart' as formProgramView;
import 'dart:developer';
import '/view/programfocus_view.dart' as Programfocus;



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
        Programfocus.ProgramFocusScreen.routeName: (context) =>
            const Programfocus.ProgramFocusScreen(),
      },
      title: 'Fitnote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('FitNote'),
          centerTitle: true,
          
        ),
        body: Container(
          child: buildListPrograms(),
        ),
        floatingActionButton: 
             FloatingActionButton(
                onPressed: () async {
                   Navigator.push(
                   context,
                  MaterialPageRoute(builder: (context) => formProgramView.programform()),
                );
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
                var programsAll = Program.deleteProgram(0);
                print(programsAll);
              },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildListPrograms() {

    Future<List<Program>> callAsyncFetch() => Future.delayed(Duration(seconds: 2), () => Program.getPrograms());

    return FutureBuilder<List<Program>>(
      future: callAsyncFetch(),
      builder: (context, AsyncSnapshot<List<Program>> snapshot) {
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
  buildRow(Program program) {
    index++;
    program.name;
    return
    ListTile(
       title: 
        Text(program.name, style: const TextStyle(
          // color:  Color(0xFF043b90),
          // fontWeight: FontWeight.bold,
            ),
          ),
         // leading: Text('Programme n°' + (index).toString()),
          onTap: (){
             Navigator.pushNamed(
                context,
                Programfocus.ProgramFocusScreen.routeName,
                arguments: Programfocus.ScreenArguments(program,
                ),
              );
          },
          trailing: IconButton(onPressed: (){
            Program.deleteProgram(program.id ?? 0);
          }, icon: const Icon(Icons.delete)),
    );
  }
}








