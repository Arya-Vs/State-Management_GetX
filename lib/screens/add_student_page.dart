import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getxmain/getX/student_viewModel.dart';
import 'package:getxmain/model/student_model.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentPage extends StatelessWidget {
  AddStudentPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _parentnameController = TextEditingController();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _rollnumberController = TextEditingController();
  String? _selectedGender;
  String? _profilePicturePath;
  XFile? image;
  @override
  Widget build(BuildContext context) {
    final StudentViewModel studentViewModel = Get.put(StudentViewModel());
    // final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // GestureDetector(
              //   onTap: () async {
              //     XFile? img = await ImagePicker()
              //         .pickImage(source: ImageSource.gallery);
              //         // Provider.of<StudentProvider>(context,listen: false).updateProfilePicture(img?.path);
              //         _profilePicturePath = img!.path;
              //   },
              //   child: CircleAvatar(
              //     radius: 50.0,
              //     backgroundImage: Provider.of<StudentProvider>(context).profilePicture != null
              //         ? FileImage(File(Provider.of<StudentProvider>(context).profilePicture!))
              //         : null,
              //     child: Provider.of<StudentProvider>(context).profilePicture == null
              //         ? const Icon(Icons.add_a_photo)
              //         : null,
              //   ),
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
                controller: _parentnameController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Address',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _ageController,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(2),
                ],
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
                    return 'Please enter your rollnumber';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16.0,
              ),
              const SizedBox(
                height: 80.0,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameController.text;
                      final address=_parentnameController.text;
                      final gender = _genderController.text;
                      final age = int.parse(_ageController.text);
                      final rollnumber = int.parse(_rollnumberController.text);
                      final student = Student(
                        id: 0,
                        name: name,
                        age: age,
                        gender: gender,
                        rollnumber: rollnumber,
                        profilePicturePath: _profilePicturePath ?? '',
                      );
                      studentViewModel.addStudent(student);
                      Get.back();
                      Get.snackbar('Success', 'Student added successfully',
                          backgroundColor: Colors.amber,
                          colorText: Colors.black,
                          snackPosition: SnackPosition.BOTTOM);
                      _profilePicturePath = null;
                      _nameController.clear();
                      _ageController.clear();
                      _genderController.clear();
                      _rollnumberController.clear();
                      _parentnameController.clear();
                    }
                  },
                  child:  Text(
                    'Save Student',
                    style:  TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
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
