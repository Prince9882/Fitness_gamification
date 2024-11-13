import 'package:flutter/material.dart';

class CustomInputFieldContainer extends StatefulWidget {

  final TextEditingController? textcontroller;
  final Key? inputKey;
  final bool? isSecureField;
  final String? placeholderText;
  final String? labelDescription;
  final String? additionalText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>?validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;

  const CustomInputFieldContainer({
    this.textcontroller,
    this.isSecureField,
    this.inputKey,
    this.placeholderText,
    this.labelDescription,
    this.additionalText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType
  });

  @override
  State<CustomInputFieldContainer> createState() => _CustomInputFieldContainerState();
}

class _CustomInputFieldContainerState extends State<CustomInputFieldContainer> {

  bool _isTextHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
      ),
      child: new TextFormField(
        style: TextStyle(color: Colors.black),
        controller: widget.textcontroller,
        keyboardType: widget.inputType,
        key: widget.inputKey,
        obscureText: widget.isSecureField == true ? _isTextHidden : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            hintText: widget.placeholderText,
            hintStyle: TextStyle(color: Colors.black54),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isTextHidden = !_isTextHidden;
                });
              },
              child: widget.isSecureField == true
                  ? Icon(_isTextHidden ? Icons.visibility_off : Icons.visibility,
                color: _isTextHidden == false ? Colors.blue : Colors.grey,)
                  : Text(""),
            ),
        ),
      ),
    );
  }
}
