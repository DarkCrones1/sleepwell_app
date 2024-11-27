import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:sleepwell_app/providers/user_providers/user_data_provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final logger = Logger();
  final formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cellphoneController = TextEditingController();
  final _birthdateController = TextEditingController();

  int? _selectedGender = 0; // Almacena el ID numérico del género.

  // Mapeo de IDs numéricos a etiquetas de género.
  final Map<int, String> _genderMap = {
    1: 'Masculino',
    2: 'Femenino',
    3: 'No binario',
    4: 'LGBTQ+',
    5: 'otro',
    0: 'Prefiero no especificarlo'
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      userDataProvider.getUserData().then((_) {
        final userData = userDataProvider.userData;
        if (userData != null) {
          _firstNameController.text = userData.firstName;
          _lastNameController.text = userData.lastName;
          _middleNameController.text = userData.middleName;
          _phoneController.text = userData.phone;
          _cellphoneController.text = userData.cellPhone;

          // Convierte el DateTime a String para mostrarlo.
          _birthdateController.text =
              userData.birthDate.toLocal().toString().split(' ')[0];

          // Asigna el género.
          _selectedGender = userData.gender;
        }
      });
    });
  }

  // Función para mostrar el selector de fecha
  Future<void> _selectBirthDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _birthdateController.text =
            selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        centerTitle: true,
      ),
      body: Consumer<UserDataProvider>(
        builder: (context, userDataProvider, child) {
          if (userDataProvider.isloading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTextField(
                    label: 'Nombre',
                    icon: Icons.person,
                    controller: _firstNameController,
                  ),
                  _buildTextField(
                    label: 'Segundo nombre',
                    icon: Icons.person_outline,
                    controller: _middleNameController,
                  ),
                  _buildTextField(
                    label: 'Apellidos',
                    icon: Icons.person_outline,
                    controller: _lastNameController,
                  ),
                  _buildTextField(
                    label: 'Teléfono',
                    icon: Icons.phone,
                    controller: _phoneController,
                  ),
                  _buildTextField(
                    label: 'Celular',
                    icon: Icons.phone_android,
                    controller: _cellphoneController,
                  ),
                  DropdownButtonFormField<int>(
                    value: _selectedGender,
                    items: _genderMap.entries
                        .map((entry) => DropdownMenuItem<int>(
                            value: entry.key, child: Text(entry.value)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Género',
                      prefixIcon: Icon(Icons.transgender),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Por favor, selecciona un género.';
                      }
                      return null;
                    },
                  ),
                  GestureDetector(
                    onTap: () => _selectBirthDate(
                        context), // Mostrar el selector de fecha
                    child: AbsorbPointer(
                      // Evita la entrada manual
                      child: _buildTextField(
                        label: 'Fecha de Nacimiento',
                        icon: Icons.cake,
                        controller: _birthdateController,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  OverflowBar(
                    children: <Widget>[
                      TextButton.icon(
                          onPressed: () {
                            logger
                                .d('First Name: ${_firstNameController.text}');
                            logger.d(
                                'Middle Name: ${_middleNameController.text}');
                            logger.d('Last Name: ${_lastNameController.text}');
                            logger.d('Phone: ${_phoneController.text}');
                            logger
                                .d('Cell Phone: ${_cellphoneController.text}');
                            logger.d('Gender: $_selectedGender');
                            logger
                                .d('Birth Date: ${_birthdateController.text}');
                            if (formKey.currentState!.validate()) {
                              context.read<UserDataProvider>().updateData(
                                    _firstNameController.text,
                                    _middleNameController.text,
                                    _lastNameController.text,
                                    _phoneController.text,
                                    _cellphoneController.text,
                                    _selectedGender!,
                                    DateTime.tryParse(
                                        _birthdateController.text)!,
                                    context,
                                  );
                            }
                          },
                          icon: const Icon(Icons.create),
                          label: const Text('Guardar Cambios')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool isDateField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: isDateField, // Mantiene el campo solo de lectura si es fecha
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (isDateField && (value == null || value.isEmpty)) {
            return 'Por favor, ingresa una fecha válida.';
          }
          return null;
        },
      ),
    );
  }
}
