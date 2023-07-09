import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class TextFormFieldAdd extends StatelessWidget {
  final TextEditingController _controller;
  final Map<String, Object> _formData;
  final String _attribute;
  final String _label;

  TextFormFieldAdd(
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
          keyboardType: TextInputType.text,
          onSaved: (value) => _formData[_attribute] = value ?? '',
        ),
      ],
    );
  }
}
