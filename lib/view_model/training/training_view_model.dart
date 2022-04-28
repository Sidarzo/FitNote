// import 'package:fitnote/model/training_session.dart';
// import 'package:flutter/material.dart';

// class TrainingViewModel extends ChangeNotifier {
//   TrainingViewModel();

//   buildExercise(index, exercise) {
//     const dividerHeight = 8.0;
//     if(exercise[index].type == "Muscu"){
//       return 
//           Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // TITLE 
//             Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               Text('Nom : ' + exercise[index].title, style: const TextStyle(fontSize: 30),)
//             ]),
//             const SizedBox(height: dividerHeight + 5),
//             // Weight
//             Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               const Icon(Icons.upcoming_outlined,size: 35,color: Color.fromARGB(255, 133, 0, 156)),
//               Text(exercise[index].weight.toString() + ' kg')
//             ]),
//             const SizedBox(height: dividerHeight),
//             /// Repet
//             Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               const Icon(Icons.repeat,size: 35,color: Color.fromARGB(255, 133, 0, 156)),
//               Text(exercise[index].repetition.toString() + ' répétitions')
//             ]),
//             const SizedBox(height: dividerHeight),
//             // Series
//             Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               const Icon(Icons.repeat_one,size: 35,color: Color.fromARGB(255, 133, 0, 156)),
//               Text(exercise[index].serie.toString() + ' séries'),
//             ]),
//             const SizedBox(height: dividerHeight),
//             // RestDuration
//             Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               const Icon(Icons.self_improvement_sharp, size: 35, color: Color.fromARGB(255, 133, 0, 156)),
//               Text(exercise[index].restDuration.toString() + ' secs')
//             ]),
              
//             const SizedBox(height: dividerHeight),
//           ],             
//         );
//     }else{
//         return  Column(mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // TITLE 
//             Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               Text('Nom : ' + exercise[index].title, style: const TextStyle(fontSize: 30),)
//               ]),
//               const SizedBox(height: dividerHeight + 5),

//               Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               const Icon(Icons.directions_run_sharp, size: 35, color: Color.fromARGB(255, 133, 0, 156)),
//               Text(exercise[index].type)
//               ]),
              
//             const SizedBox(height: dividerHeight),
//               // Weight
//               Row(mainAxisAlignment: MainAxisAlignment.center,children: [
//               const Icon(Icons.timer_outlined,size: 35,color: Color.fromARGB(255, 133, 0, 156)),
//               Text(exercise[index].duration.toString() + ' mins')
//               ]),
//             const SizedBox(height: dividerHeight),
//         ],             
//       );      
//      }
//   }

//     void createSessionButtonOnClickCommand(programId) async {
//       TrainingSession.insertTrainingSession(programId);
//     }
// }
