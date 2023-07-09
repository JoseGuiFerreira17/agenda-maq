import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class PassFormFieldAdd extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;
  final Map<String, Object> _formData;
  final String _attribute;

  const PassFormFieldAdd(
      this._controller, this._label, this._attribute, this._formData);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: _label,
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AgendaColors.setGreen,
              ),
            ),
          ),
          controller: _controller,
          obscureText: true,
          keyboardType: TextInputType.text,
          onSaved: (value) => _formData[_attribute] = value ?? '',
        ),
      ],
    );
  }
}
