import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? selectedImage;
  String base64Image = "";

  Future chooseImage() async {
    var image;

    image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  final name = TextEditingController();

  final email = TextEditingController();

  final rollNo = TextEditingController();

  final instaId = TextEditingController();

  final phoneNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/images/bg.png"),
        fit: BoxFit.cover,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 45,
              ),
              GestureDetector(
                onTap: () {
                  chooseImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                      child: selectedImage != null
                          ? Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                          : Image.asset(
                              'assets/images/member.png',
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 300,
                height: 45,
                child: TextField(
                  controller: name,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: TextField(
                  controller: email,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: TextField(
                  controller: rollNo,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Roll number',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: TextField(
                  controller: instaId,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Instagram Id',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              SizedBox(
                width: 300,
                height: 45,
                child: TextField(
                  controller: phoneNo,
                  cursorColor: const Color.fromARGB(255, 255, 255, 255),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDisplay(
                                name: name.text,
                                email: email.text,
                                roll: rollNo.text,
                                insta: instaId.text,
                                phone: phoneNo.text,
                              )),
                    );
                    const Duration(seconds: 2);
                  },
                  style: ElevatedButton.styleFrom(
                      maximumSize: const Size(300, 50),
                      backgroundColor: const Color.fromARGB(255, 184, 151, 213),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserDisplay extends StatelessWidget {
  String name, email, roll, phone, insta;
  UserDisplay(
      {super.key,
      required this.name,
      required this.email,
      required this.roll,
      required this.phone,
      required this.insta});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(children: [
              Container(
                height: 60,
                color: Color.fromARGB(255, 64, 64, 116).withOpacity(0.8),
                padding: EdgeInsets.only(top: 6),
                child: const Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              Container(
                width: 260,
                height: 304,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/member.png'),
                    ),
                    const SizedBox(
                      height: 15.75,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 64, 64, 116)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      email,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 64, 64, 116)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      roll,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 64, 64, 116)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      phone,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 64, 64, 116)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      insta,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 64, 64, 116)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Profile()));
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 35),
                          backgroundColor:
                              const Color.fromARGB(255, 184, 151, 213),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                  const SizedBox(
                    width: 17,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 35),
                          backgroundColor:
                              const Color.fromARGB(255, 184, 151, 213),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25))),
                      child: const Center(
                        child: Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      )),
                ],
              )
            ]),
          ),
        ));
  }
}
