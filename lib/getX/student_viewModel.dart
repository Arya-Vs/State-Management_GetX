import 'package:get/get.dart';
import 'package:getxmain/db/database_helper.dart';
import 'package:getxmain/model/student_model.dart';

class StudentViewModel extends GetxController{
  var allStudents = <Student>[].obs;
  DatabaseHelper dbHelper = DatabaseHelper();
  RxList<Student> searchResult = <Student>[].obs;

  fetchAllStudents()async{
    var student = await dbHelper.getStudents();
    allStudents.value = student;
  }

  addStudent(Student studentModel){
    dbHelper.insertStudent(studentModel);
    fetchAllStudents();
  }

  updateStudent(Student studentModel)async{
    await dbHelper.updateStudent(studentModel);
    fetchAllStudents();
  }

  deleteStudent(int id){
    dbHelper.deleteStudent(id);
    fetchAllStudents();
  }
}