import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:questanaire_app/models/user_model.dart';
import 'package:questanaire_app/provider/auth_provider.dart';
import 'package:questanaire_app/responsive/responsive.dart';
import 'package:questanaire_app/screens/home_screen.dart';
import 'package:questanaire_app/widgets/custom_button.dart';
import 'package:questanaire_app/widgets/pick_image.dart';
import 'package:questanaire_app/widgets/snackBar.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  // Future pickkImage() async {
  //   File? image;
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (image == null) return;
  //     final imageTemp = File(image.path);
  //     setState(() => this.image = imageTemp);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: R.sh(24, context),
            horizontal: R.sw(6, context),
          ),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.purple,
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: R.sh(24, context),
                    horizontal: R.sw(4, context),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => selectImage(),
                          child: image == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.purple,
                                  radius: R.sw(50, context),
                                  child: Icon(
                                    Icons.account_circle,
                                    size: R.sw(50, context),
                                    color: Colors.white,
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(image!),
                                  radius: R.sw(50, context),
                                ),
                        ),
                        SizedBox(height: R.sh(24, context)),
                        Container(
                          width: R.sw(375, context),
                          padding: EdgeInsets.symmetric(
                            vertical: R.sh(4, context),
                            horizontal: R.sw(14, context),
                          ),
                          margin: EdgeInsets.only(
                            top: R.sh(4, context),
                          ),
                          child: Column(
                            children: [
                              // name field
                              textField(
                                hintText: "John Smith",
                                icon: Icons.account_circle,
                                inputType: TextInputType.name,
                                maxLines: 1,
                                controller: nameController,
                              ),
                              // email
                              textField(
                                hintText: "abc@gmail.com",
                                icon: Icons.email,
                                inputType: TextInputType.emailAddress,
                                maxLines: 1,
                                controller: emailController,
                              ),
                              // bio
                              textField(
                                hintText: "Enter your bio here...",
                                icon: Icons.edit,
                                inputType: TextInputType.name,
                                maxLines: 2,
                                controller: bioController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: R.sh(20, context)),
                        SizedBox(
                          width: R.sw(330, context),
                          child: CustomButton(
                            onPressed: () => storeData(),
                            text: "Continue",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: R.sh(10, context),
      ),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.all(R.sw(8, context)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.purple),
            child: Icon(
              icon,
              size: R.sw(20, context),
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  // store userdata
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      bio: bioController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}
