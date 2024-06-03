import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxmain/getX/student_viewModel.dart';
import 'package:getxmain/model/student_model.dart';

class EditStudentPage extends GetView<StudentViewModel> {
  EditStudentPage({super.key, required this.student}) {
    _nameController.text = student.name;
    _ageController.text = student.age.toString();
    _genderController.text = student.gender;
    _rollnumberController.text = student.rollnumber.toString();
  }
  final Student student;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _rollnumberController = TextEditingController();
   String? _selectedGender;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Edit Student ${student.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CircleAvatar(
              //   radius: 50.0,
              //   backgroundImage:
              //       FileImage(File(updatedStudent.profilePicturePath)),
              // ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an age';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                onChanged: (String? newValue) {
                  // setState(() {
                  //   _selectedGender = newValue;
                  // });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Gender',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a gender';
                  }
                  return null;
                },
                items: <String>['Male', 'Female']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _rollnumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'RollNumber',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter rollnumber';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 80.0,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final age = int.parse(_ageController.text);
                      final rollnumber = int.parse(_rollnumberController.text);
                      final updateStudent = Student(
                        id: student.id,
                        name: name,
                        age: age,
                        gender: _genderController.text,
                        rollnumber: rollnumber,
                        profilePicturePath:'',
                      );
                      // studentViewModel.updateStudent(updateStudent);
                      Get.find<StudentViewModel>().updateStudent(updateStudent);
                      Get.back();
                      Get.snackbar('Updated', 'Student Updated',
                      backgroundColor: Colors.amber,
                      colorText: Colors.black);
                    }
                  },
                  child: const Text(
                    'Edit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
