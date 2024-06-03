import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmain/getX/student_viewModel.dart';
import 'package:getxmain/screens/add_student_page.dart';
import 'package:getxmain/screens/student_details_page.dart';

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final StudentViewModel studentList = Get.put(StudentViewModel());

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData()async{
    await studentList.fetchAllStudents();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        toolbarHeight: 70,
        title: const Padding(
          padding: EdgeInsets.only(top: 25.0),
          child: Text(
            'GetX ',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            Get.to(()=>AddStudentPage());
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: Column(
        children: [
          Obx(() => studentList.allStudents.isEmpty
          ? const Center(
                  child: Text(
                    'No Students Data Available'
                  ),
                )
          : Expanded(
            child:  GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: studentList.allStudents.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(()=>StudentDetailPage(student: studentList.allStudents[index]));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40.0,
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 8.0),
                    Text(studentList.allStudents[index].name),
                  ],
                ),
              );
            }
            )
            ),
          )
        ],
      ),
    );
  }
}