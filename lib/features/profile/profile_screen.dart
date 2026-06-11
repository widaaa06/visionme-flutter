import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../auth/login_screen.dart';
import 'activity_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  String role = 'guest';
  String name = 'Pengguna VisionMe';
  String email = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final authService = AuthService();

    final isLoggedIn =
        await authService.isLoggedIn();

    final userName =
        await authService.getUserName();

    final userEmail =
        await authService.getUserEmail();

    if (!mounted) return;

    setState(() {
      role = isLoggedIn ? 'user' : 'guest';
      name = userName ?? 'Pengguna VisionMe';
      email = userEmail ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPremium = role == 'user';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90E2),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profil Saya",
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
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF4A90E2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isPremium
                          ? Colors.amber
                          : Colors.white24,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: Text(
                      isPremium
                          ? "Premium User"
                          : "Guest User",
                      style: TextStyle(
                        color: isPremium
                            ? Colors.black
                            : Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  _buildMenuCard(
                    icon: Icons.edit,
                    title: "Edit Profil",
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const EditProfileScreen(),
                        ),
                      );
                    },
                  ),

                  _buildMenuCard(
                    icon: Icons.history,
                    title: "Aktivitas",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const ActivityScreen(),
                        ),
                      );
                    },
                  ),

                  Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(18),
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
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CircleAvatar(
                        backgroundColor:
                            Colors.amber.shade100,
                        child: Icon(
                          Icons.workspace_premium,
                          color: isPremium
                              ? Colors.amber
                              : Colors.grey,
                        ),
                      ),
                      title: const Text(
                        "Status Premium",
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        isPremium
                            ? "Aktif"
                            : "Belum Berlangganan",
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      style:
                          ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red,
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                  15),
                        ),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                            title:
                                const Text("Logout"),
                            content: const Text(
                              "Apakah Anda yakin ingin keluar dari akun?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context);
                                },
                                child:
                                    const Text(
                                  "Batal",
                                ),
                              ),
                              ElevatedButton(
                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red,
                                ),
                                onPressed:
                                    () async {
                                  await AuthService()
                                      .logout();

                                  if (!mounted) {
                                    return;
                                  }

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const LoginScreen(),
                                    ),
                                    (route) =>
                                        false,
                                  );
                                },
                                child:
                                    const Text(
                                  "Keluar",
                                  style:
                                      TextStyle(
                                    color: Colors
                                        .white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor:
              color.withOpacity(0.15),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),
        onTap: onTap,
      ),
    );
  }
}