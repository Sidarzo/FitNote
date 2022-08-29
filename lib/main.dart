import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// component
import '../component/custom_app_bar.dart';

// view
import 'view/landing_view.dart';
import '/view/exercise/exercise_form.dart';
import '/view/program/programfocus_view.dart';
import '/view/program/program_form.dart';
import '/view/training/training_view.dart';

// model
import '../model/program.dart';

// view model
import 'view_model/dashboard_view_model.dart';
import 'view_model/program/programform_view_model.dart';
import 'view_model/program/programfocus_view_model.dart';
import 'view_model/exercise/exerciseform_view_model.dart';
import 'view_model/training/training_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromARGB(255, 32, 32, 32),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: Router.generateRoute,
      title: 'Fitnote',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingView(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DashboardViewModel _dvm;

  @override
  void initState() {
    _dvm = Provider.of<DashboardViewModel>(context, listen: false);
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 32, 32, 32),
            title: const Text('FitNote'),
            centerTitle: true,
          ),
          body: Column(
            children: [ 
              buildTopApp(),
              buildListPrograms()
            ],
          ),
          drawer: Drawer(
            child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
          bottomNavigationBar: CustomBottomAppBar.buildAppBar(context)),
    );
  }

  buildListPrograms() {
    Future<List<Program>> callAsyncFetch() => Future.delayed(
        const Duration(milliseconds: 10), () => _dvm.getPrograms());
    return FutureBuilder<List<Program>>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<List<Program>> snapshot) {
          if (snapshot.hasData) {
            return 
              SizedBox(
            height: MediaQuery.of(context).size.height - 434,
            child: 
            GridView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount: 2,
                        ),
                itemBuilder: (context, i) {
                  return buildRow(snapshot.data![i]);
                  
                }
              )
            );
          } else {
            return Column(
              children: const [
                Center(child: CircularProgressIndicator(),)]);
          }
        });
  }

  buildRow(Program program) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController nameEditingController = TextEditingController();
    return 
    Card(
      margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
      child: InkWell(
        onTap: (() {
          Navigator.pushNamed(context, '/focusprogram', arguments: program);
        }),
        child: Container(
        height: 10,
        width: 10,
        child: Center(child: Text(program.name)
            ),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 228, 118, 250),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 218, 74, 247),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    spreadRadius: 1,      
                  ),
                  
                ],
                borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        )  
        );
      
    
    
        
        
      
        
        
            // return ListTile(
    //   title: Text(
    //     program.name,
    //     style: const TextStyle(
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   onTap: () {
    //     Navigator.pushNamed(context, '/focusprogram', arguments: program);
    //   },
    //   leading: IconButton(
    //     onPressed: () {
    //       showModalBottomSheet<void>(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return Container(
    //             height: 500,
    //             color: Colors.white,
    //             child: Center(
    //               child: Form(
    //                 key: _formKey,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(16.0),
    //                       child: TextFormField(
    //                         controller: nameEditingController,
    //                         decoration: const InputDecoration(
    //                             label: Text('Nouveau nom du programme')),
    //                         validator: (formName) {
    //                           if (formName == null || formName.isEmpty) {
    //                             return 'Rentrez un nom valide';
    //                           }
    //                           return null;
    //                         },
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.symmetric(vertical: 16.0),
    //                       child: Center(
    //                         child: ElevatedButton(
    //                           style: ButtonStyle(
    //                               backgroundColor: MaterialStateProperty.all(
    //                                   const Color.fromARGB(255, 133, 0, 156))),
    //                           onPressed: () async {
    //                             if (_formKey.currentState!.validate()) {
    //                               String name = nameEditingController.text;
    //                               var newProgram = Program(
    //                                 id: program.id,
    //                                 name: name,
    //                               );
    //                               setState(() {
    //                                 _dvm.updateProgram(newProgram);
    //                               });
    //                             }
    //                           },
    //                           child: const Text('Modifier le nom du programme'),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //     icon: const Icon(
    //       Icons.edit,
    //       color: Colors.grey,
    //     ),
    //   ),
    //   trailing: IconButton(
    //     onPressed: () {
    //       setState(() {
    //         _dvm.deleteProgram(program.id ?? 0);
    //       });
    //     },
    //     icon: const Icon(Icons.delete),
    //     color: Colors.red,
    //   ),
    //   hoverColor: Colors.grey,
    // );
  }
}

buildTopApp(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
    Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.fromLTRB(30, 20, 0, 5),
      child: const Text('Mes programmes',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500
        ),
      ),
    ),
    Container(
        height: 200,
        margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: const Color.fromARGB(255, 218, 74, 247),
          boxShadow: const [
            BoxShadow(
               color: Color.fromARGB(255, 218, 74, 247),
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    spreadRadius: 1,      
            )
          ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Test'),
            Text('test'),
          ],
        ),
      ),
    ],
  );
  
  

}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const LandingView());
      case '/dashboard':
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => DashboardViewModel(),
                child: const HomePage()));
      case '/programform':
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => ProgramFormViewModel(),
                child: const Programform()));
      case '/focusprogram':
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                create: (context) => ProgramFocusViewModel(),
                child: ProgramFocusScreen(program: data)));
      case '/excersieform':
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => ExerciseFormViewModel(),
                  child: Exerciseform(program: data),
                ));
      case '/startTraining':
        var datas = settings.arguments;
        return MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => TrainingViewModel(),
                  child: TrainingView(exercises: datas),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
