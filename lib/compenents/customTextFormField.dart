import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String campo;
  final TextEditingController controlador;
  final bool isPassword; // Indica se o campo é uma senha
  final IconData? prefixIcon;

  const CustomTextFormField({
    Key? key,
    required this.campo,
    required this.controlador,
    this.isPassword = false, // Valor padrão para o campo não ser uma senha
    this.prefixIcon, // Incluído o parâmetro prefixIcon
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controlador,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration(
          labelText: widget.campo,
          hintText: widget.campo,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  color: Colors.purple,
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          prefixIconColor: Colors.purple,
        ),
      ),
    );
  }
}
