// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {super.key,
      this.prficon,
      this.colorform,
      this.maxLength,
      required this.hinitext,
      required this.textEditingController,
      required this.validat,
      this.onfilld,
      this.labels,
      this.readOnly,
      this.keyboardType});
  final String hinitext;
  final TextEditingController textEditingController;
  // ignore: non_constant_identifier_names
  final String? Function(String? b) validat;
  final Function(String? j)? onfilld;
  final TextInputType? keyboardType;
  final Color? colorform;
  final Widget? prficon;
  final String? labels;

  final int? maxLength;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: const EdgeInsets.all(10),
      cursorHeight: 20,
      readOnly: readOnly == null ? false : true,
      onChanged: onfilld,
      controller: textEditingController,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 20, decorationColor: Colors.white),
      maxLines: 1,
      maxLength: maxLength,
      validator: validat,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
          labelText: labels,
          prefixIcon: prficon,
          hintText: hinitext,
          //  error: Text(error ?? ""),
          hintStyle: const TextStyle(color: Colors.black45),
          errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.red, width: 1.25)),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Colors.black, width: 1.25)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1.25)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2))),
    );
  }
}
