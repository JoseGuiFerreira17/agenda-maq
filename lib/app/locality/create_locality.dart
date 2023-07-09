import 'package:agendamaq/app/components/text_form.dart';
import 'package:agendamaq/controller/locality_controller.dart';
import 'package:agendamaq/models/locality.dart';
import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateLocality extends StatefulWidget {
  const CreateLocality({super.key});

  @override
  State<CreateLocality> createState() => _CreateLocalityState();
}

class _CreateLocalityState extends State<CreateLocality> {
  final Map<String, Object> _formData = {};
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<LocalityController>(context, listen: false)
          .createLocality(_formData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Center(child: Text('Localidade cadastrada com sucesso')),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    } else {
      print('Não Validado');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final locality = ModalRoute.of(context)!.settings.arguments as Locality?;
      if (locality != null) {
        _formData['id'] = locality.id;
        _formData['name'] = locality.name;
        _formData['latitude'] = locality.latitude;
        _formData['longitude'] = locality.longitude;
        _nameController.text = locality.name;
        _latitudeController.text = locality.latitude;
        _longitudeController.text = locality.longitude;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AgendaColors.setGreen,
        title: const Text('Cadastrar Localidade'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                TextFormFieldAdd(_nameController, 'Nome', 'name', _formData),
                const SizedBox(height: 20),
                TextFormFieldAdd(
                    _latitudeController, 'Latitude', 'latitude', _formData),
                const SizedBox(height: 20),
                TextFormFieldAdd(
                    _longitudeController, 'Longitude', 'longitude', _formData),
                const SizedBox(height: 50),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        _submitForm();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AgendaColors.setGreen),
                      child: const Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
