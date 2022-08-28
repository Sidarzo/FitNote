// import 'package:fitnote/model/api_model.dart';
// import 'package:flutter/cupertino.dart';
// import '../config/app_settings.dart';

// class TrainingSession extends ApiModel {
//   final int? id;

//   final DateTime dateSession;
//   // ignore: non_constant_identifier_names
//   final int? program_id;



//   TrainingSession({
//     required this.id,
//     required this.dateSession,
//     // ignore: non_constant_identifier_names
//     required this.program_id,
//   });




//   TrainingSession.fromMap(Map<String, dynamic> res)
//       : id = res['id'],
//         dateSession = res['dateSession'],
//         program_id = res['program_id'];

//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'dateSession': dateSession,
//       'program_id': program_id,
//     };
//   }


//   static insertTrainingSession(int programId) async {
      
//     await ApiModel.post(
//         AppSettings.API_URL + 'createTrainingSession/',
//         {'dateSession' : DateTime.now().toString(),'program_id' : programId.toString()});
//   }
 
// }
