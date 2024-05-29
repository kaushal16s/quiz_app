import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz_app/service/database.dart';
import 'package:random_string/random_string.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

class AddQuiz extends StatefulWidget {
  const AddQuiz({Key? key}) : super(key: key);

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImageFile;
  String? selectedImageUrl;

  final List<String> quizItems = [
    'Place',
    'Film',
    'Cricket',
    'Music',
    'Career',
    'Food'
  ];

  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();
  final TextEditingController correctController = TextEditingController();

  String? value;

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (kIsWeb) {
          selectedImageUrl = pickedFile.path;
        } else {
          selectedImageFile = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> uploadItem() async {
    if ((selectedImageFile != null || selectedImageUrl != null) &&
        option1Controller.text.isNotEmpty &&
        option2Controller.text.isNotEmpty &&
        option3Controller.text.isNotEmpty &&
        option4Controller.text.isNotEmpty &&
        correctController.text.isNotEmpty) {
      String addId = randomAlphaNumeric(7);
      String downloadUrl;

      if (kIsWeb && selectedImageUrl != null) {
        final Uint8List fileBytes = await XFile(selectedImageUrl!).readAsBytes();
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('Images')
            .child(addId);
        UploadTask uploadTask = firebaseStorageRef.putData(
          fileBytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        downloadUrl = await (await uploadTask).ref.getDownloadURL();
      } else if (selectedImageFile != null) {
        Reference firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('Images')
            .child(addId);
        UploadTask uploadTask = firebaseStorageRef.putFile(selectedImageFile!);
        downloadUrl = await (await uploadTask).ref.getDownloadURL();
      } else {
        return;
      }

      Map<String, dynamic> addQuiz = {
        "Image": downloadUrl,
        "option1": option1Controller.text,
        "option2": option2Controller.text,
        "option3": option3Controller.text,
        "option4": option4Controller.text,
        "correct": correctController.text
      };

      await DatabaseMethods().addQuizCategory(addQuiz, value!).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Quiz has been added'),
          ),

        );
        clearForm();
      });
    }
  }

  void clearForm() {
    setState(() {
      selectedImageFile = null;
      selectedImageUrl = null;
      option1Controller.clear();
      option2Controller.clear();
      option3Controller.clear();
      option4Controller.clear();
      correctController.clear();
      value = null;
    });
  }

  Widget buildOptionField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xFFececf8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter The Option",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add Quiz',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload Picture",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: (selectedImageUrl == null && selectedImageFile == null)
                      ? Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.amber,
                      ),
                    ),
                  )
                      : Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: kIsWeb
                          ? Image.network(
                        selectedImageUrl!,
                        fit: BoxFit.cover,
                      )
                          : Image.file(
                        selectedImageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              buildOptionField('Option 1', option1Controller),
              SizedBox(height: 20.0),
              buildOptionField('Option 2', option2Controller),
              SizedBox(height: 20.0),
              buildOptionField('Option 3', option3Controller),
              SizedBox(height: 20.0),
              buildOptionField('Option 4', option4Controller),
              SizedBox(height: 20.0),
             buildOptionField('correct', correctController),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: correctController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Correct Option",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: quizItems
                        .map(
                          (item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Color(0xFFE8EAF6),
                    hint: Text('Select Category'),
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: uploadItem,
                child: Center(
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
