import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../component/custom_app_bar.dart';
import '../model/program.dart';
import '../view_model/dashboard_view_model.dart';

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
            flexibleSpace: Container(
              decoration: const BoxDecoration(
            gradient:  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                    Color.fromARGB(255, 97, 255, 218),
                    Color.fromARGB(255, 0, 241, 189),
                    ],
                    tileMode: TileMode.clamp,
                ), 
              ),
            ),
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


// TOP APP
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
          borderRadius: BorderRadius.circular(7.0),
         // color: Color.fromRGBO(218, 255, 247, 1),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8, 1),
            colors: <Color>[
              Color.fromARGB(255, 206, 250, 240),
              Color.fromARGB(255, 160, 253, 233),
            ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.clamp,
        ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 191, 250, 236),
              offset: Offset(0, 2),
              blurRadius: 3,
              spreadRadius: 1,      
            ),    
          ],
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              const Image(image: AssetImage('assets/images/topAppimg2.jpg')),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                    Icon(Icons.access_time),
                    Text('${ 100 } mins')
                    ]
                  ),
                  const Divider(
                    height: 10,
                  ),
                  Row(
                    children: const [
                      Icon(Icons.format_list_numbered),
                      Text('${ 10 } programmes')
                    ],
                  )
                ],
              )
            ],
          ),
        )    
      ),
    ],
  );
}

// Programs LIST 
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
                            crossAxisSpacing: 1,
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
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
      child: InkWell(
        onTap: (() {
          Navigator.pushNamed(context, '/focusprogram', arguments: program);
        }),
        child: Container(
        height: 10,
        width: 10,
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(program.name, style: TextStyle(fontSize: 12),),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.access_time),
              Text(program.duration.toString() + ' mins')
            ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Réalisé ${program.realized} fois')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 500,
                          color: Colors.white,
                          child: Center(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: TextFormField(
                                      controller: nameEditingController,
                                      decoration: const InputDecoration(
                                          label: Text('Nouveau nom du programme')),
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
                                            var newProgram = Program(
                                              id: program.id,
                                              name: name,
                                              duration: 120,
                                              realized: 12
                                            );
                                            setState(() {
                                              _dvm.updateProgram(newProgram);
                                            });
                                          }
                                        },
                                        child: const Text('Modifier le nom du programme'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.grey,
                  ),
                ),
              ]
            )
          ],
        ),
        ),   
        decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.9, 1),
                  colors: <Color>[
                   Color.fromARGB(255, 191, 250, 236),
                   Color.fromARGB(255, 170, 250, 231),
                   Color.fromARGB(255, 160, 253, 233),
                ], // Gradient from https://learnui.design/tools/gradient-generator.html
            tileMode: TileMode.clamp,
        ),
                 boxShadow: const [
                   BoxShadow(
                     color: Color.fromARGB(255, 191, 250, 236),
                     offset: Offset(0, 2),
                     blurRadius: 3,
                     spreadRadius: 1,      
                   ),    
                 ],
                borderRadius: BorderRadius.circular(7.0),
            ),
          ),
        )  
      );
  }
}