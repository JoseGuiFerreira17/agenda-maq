import 'package:agendamaq/static/utils.dart';
import 'package:flutter/material.dart';

class PassFormFieldAdd extends StatelessWidget {
  final TextEditingController _controller;
  final String _label;

  const PassFormFieldAdd(this._controller, this._label, {super.key});

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
        ),
      ],
    );
  }
}
