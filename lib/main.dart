import 'package:flutter/material.dart';
import '../model/program.dart';
import 'dart:developer';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  late Future<List<Program>> program = Program.getPrograms() ;

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
          child: buildListFiles(program),
        ),
        floatingActionButton: 
             FloatingActionButton(
                onPressed: () async {
                  var fido = Program(
                    id: null,
                    name: 'Fido',
                  );

                  await Program.insertProgram(fido);
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
                var programsAll = Program.getPrograms();
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

  buildListFiles(programs) {

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
          return CircularProgressIndicator();
        }
      }
    );

  }



  buildRow(Program program) {
    program.name;
    return
    ListTile(
       title: 
        Text(program.name, style: TextStyle(
          color:  Color(0xFF043b90),
          fontWeight: FontWeight.bold,
            ),
          ),
    );
  }
}








