
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(
        onPressed: () =>openFile(
        url:'https://www.africau.edu/images/default/sample.pdf',
        fileName:'sample.pdf',
        ),
      child: Text('Download'),)),
    );
  }
    Future openFile({required String url,String? fileName})async{
      final file = await downloadFile(url,fileName!);

      if(file==null)return;
      print('path: ${file.path}');
     
      OpenFile.open(file.path);
    }
    Future<File?>downloadFile(String url,String name)async{
      // print('doc');
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$name');

try{
      final response = await Dio().get(
        url,
        options:Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          // receiveTimeout: 0,

        )
      );
   final raf = file.openSync(
    mode:FileMode.write,
   );
   await raf.close();
   return file;
  }
  catch(e){
    return null;
  }
}
}