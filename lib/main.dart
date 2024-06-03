
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmain/db/database_helper.dart';
import 'package:getxmain/getX/student_viewModel.dart';
import 'package:getxmain/screens/student_list_page.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(StudentViewModel());
  runApp(StudentRecordApp());
  await DatabaseHelper().initDatabase();
}

class StudentRecordApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp( 
      title: 'GetX Student Management',
      debugShowCheckedModeBanner: false,
      home: StudentList(),
    );
  }
  
}
