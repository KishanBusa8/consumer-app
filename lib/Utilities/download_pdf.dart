// import 'dart:io';
// import 'package:email_validator/email_validator.dart';
// import 'package:path_provider/path_provider.dart' as p;
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:hashching/models/change_notifier.dart';
//
// class Download_pdf {
//   String _fileFullPath;
//   String progress;
//   bool _isLoading = false;
//   final urlPdf = "https://hashching.s3.ap-southeast-2.amazonaws.com/public_docs/Copy+of+Client+Pack+-+Conveyancing.pdf";
//
//   @override
//   void initState(){
//     dio = Dio();
//     super.initState();
//   }
//
//   Future<List<Directory>> _getExternalStoragePath(){
//     return  p.getExternalStorageDirectories(type:p.getExternalStorageDirectory().documents);
//   }
//
//   Future _downloadAndSaveFileToStorage(String url, String fileName)async{
//     try{
//       final dirList = await _getExternalStoragePath();
//       final path = dirList[0].path;
//       final file = File('$path/filename');
//       aws dio.download(urlPath,file.path,
//           onReceveProgress:(rec,total){
//         setState(){
//           _isLoading = true;
//           progress = ((rec/total)*100).toStringAsFixed(0) + " %";
//           print(progress);
//         }
//           }
//       );
//     }
//     catch(e){
//       print(e);
//     }
//   }
//
//
// }