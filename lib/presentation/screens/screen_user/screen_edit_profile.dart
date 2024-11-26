import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      label: 'Nombre(s)',
                      icon: Icons.person,
                      hintText: 'Escribe tu nombre',
                    ),
                    _buildTextField(
                      label: 'Apellido Paterno',
                      icon: Icons.person_outline,
                      hintText: 'Escribe tu apellido paterno',
                    ),
                    _buildTextField(
                      label: 'Apellido Materno',
                      icon: Icons.person_outline,
                      hintText: 'Escribe tu apellido materno',
                    ),
                    _buildTextField(
                      label: 'Teléfono',
                      icon: Icons.phone,
                      hintText: 'Escribe tu número de teléfono',
                    ),
                    _buildTextField(
                      label: 'Celular',
                      icon: Icons.phone_android,
                      hintText: 'Escribe tu número de celular',
                    ),
                    _buildTextField(
                      label: 'Género',
                      icon: Icons.transgender,
                      hintText: 'Selecciona tu género',
                      isDropdown: true,
                      dropdownItems: const ['Masculino', 'Femenino', 'Otro'],
                    ),
                    _buildTextField(
                      label: 'Fecha de Nacimiento',
                      icon: Icons.cake,
                      hintText: 'DD/MM/AAAA',
                      isDateField: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 64, 217, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'Guardar Cambios',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    String? hintText,
    bool isDropdown = false,
    bool isDateField = false,
    List<String>? dropdownItems,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 6),
          isDropdown
              ? DropdownButtonFormField<String>(
                  items: dropdownItems!
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ))
                      .toList(),
                  onChanged: (value) {
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(icon),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                )
              : TextFormField(
                  onTap: isDateField
                      ? () {
                        }
                      : null,
                  readOnly: isDateField,
                  decoration: InputDecoration(
                    prefixIcon: Icon(icon),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: hintText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
