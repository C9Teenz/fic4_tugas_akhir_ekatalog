// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  const DialogWidget({
    Key? key,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
  }) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'Title'),
          controller: widget.titleController,
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Price'),
          controller: widget.priceController,
          keyboardType: TextInputType.number,
        ),
        TextField(
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Description'),
          controller: widget.descriptionController,
        ),
      ],
    );
  }
}
