import 'package:flutter/material.dart';
import 'package:hashching/Utilities/simplefiedwidgets.dart';
import 'package:hashching/styles/styles.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NewColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('How can we help you?', style: BoldHeader.secondaryText),
        Container(
          child: TextFormField(
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: const EdgeInsets.all(8),
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return "please enter a message";
                }
                return null;
              }),
        ),
      ],
    );
  }
}
