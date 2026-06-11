import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    nameController.text = "Pengguna VisionMe";
    emailController.text =
        "user@gmail.com";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Profil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme:
            const IconThemeData(color: Colors.white),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 25,
                bottom: 35,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF4A90E2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 4,
                          ),
                        ),
                        child: const CircleAvatar(
                          radius: 55,
                          backgroundColor:
                              Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color:
                                Color(0xFF4A90E2),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding:
                              const EdgeInsets.all(8),
                          decoration:
                              const BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Ubah Data Profil",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Container(
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          20),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.grey.shade200,
                      blurRadius: 10,
                      offset:
                          const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TextField(
                      controller:
                          nameController,
                      decoration:
                          InputDecoration(
                        labelText: "Nama",
                        prefixIcon:
                            const Icon(
                          Icons.person,
                          color: Color(
                              0xFF4A90E2),
                        ),
                        filled: true,
                        fillColor:
                            Colors.grey.shade50,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    TextField(
                      controller:
                          emailController,
                      keyboardType:
                          TextInputType
                              .emailAddress,
                      decoration:
                          InputDecoration(
                        labelText: "Email",
                        prefixIcon:
                            const Icon(
                          Icons.email,
                          color: Color(
                              0xFF4A90E2),
                        ),
                        filled: true,
                        fillColor:
                            Colors.grey.shade50,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    TextField(
                      obscureText: true,
                      decoration:
                          InputDecoration(
                        labelText:
                            "Password Baru",
                        prefixIcon:
                            const Icon(
                          Icons.lock,
                          color: Color(
                              0xFF4A90E2),
                        ),
                        filled: true,
                        fillColor:
                            Colors.grey.shade50,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(
                                      15),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(
                        height: 30),

                    SizedBox(
                      width:
                          double.infinity,
                      height: 55,
                      child:
                          ElevatedButton.icon(
                        icon: const Icon(
                          Icons.save,
                          color:
                              Colors.white,
                        ),
                        label: const Text(
                          "Simpan Perubahan",
                          style:
                              TextStyle(
                            color: Colors
                                .white,
                            fontSize: 16,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              const Color(
                                  0xFF4A90E2),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        15),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger
                                  .of(
                                      context)
                              .showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  const Color(
                                      0xFF4A90E2),
                              behavior:
                                  SnackBarBehavior
                                      .floating,
                              shape:
                                  RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            12),
                              ),
                              content:
                                  const Text(
                                "Profil berhasil diperbarui",
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}