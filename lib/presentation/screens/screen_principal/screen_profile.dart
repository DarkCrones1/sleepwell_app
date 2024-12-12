import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/providers/user_providers/user_data_provider.dart';
import 'package:sleepwell_app/providers/user_providers/user_login_provider.dart';

class ScreenProfilePage extends StatelessWidget {
  const ScreenProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDataToken = UserLoginProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<UserDataProvider>(
        builder: (context, userDataProvider, child) {
          if (userDataProvider.isloading) {
            // Puedes mostrar un loader mientras se obtienen los datos
            return const Center(child: CircularProgressIndicator());
          }

          final userData = userDataProvider.userData;

          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 400,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.asset(
                                  'image/SleepWell.png', // O usa la imagen del perfil si está disponible
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              userData?.fullName ?? 'Nombre',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              userData?.email ?? 'Correo',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/screen_packages');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(0xFF40D9FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                              ),
                              child: const Text(
                                'Cambiar a Premium',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 400,
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            _buildOptionItem(
                              context,
                              icon: Icons.person,
                              text: 'Editar perfil',
                              onTap: () {
                                Navigator.pushNamed(context, '/edit_profile');
                              },
                            ),
                            _buildOptionItem(
                              context,
                              icon: Icons.settings,
                              text: 'Permisos',
                              onTap: () {
                                Navigator.pushNamed(context, '/screen_permissions');
                              },
                            ),
                            // _buildOptionItem(
                            //   context,
                            //   icon: Icons.devices,
                            //   text: 'Vincular dispositivo',
                            //   onTap: () {
                            //     Navigator.pushNamed(context, '/screen_wearable');
                            //   },
                            // ),
                            _buildOptionItem(
                              context,
                              icon: Icons.settings,
                              text: 'Elegir Tema',
                              onTap: () {
                                Navigator.pushNamed(context, '/theme');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Acción para cerrar sesión
                      userDataToken.clearAuthToken();
                      Navigator.popAndPushNamed(context, '/log_in');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text(
                      'Cerrar sesión',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOptionItem(BuildContext context,
      {required IconData icon,
      required String text,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(
        text,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: onTap,
    );
  }
}
