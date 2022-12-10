import 'package:flutter/material.dart';

void showNewDialog(BuildContext context, Widget widget, bool dismissible) {
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) {
      return widget;
    },
  );
}

Future<void> showSetTargetDialog(
    BuildContext context, TextEditingController targetController) async {
  return await showDialog(
      context: context,
      builder: (context) {
        int? type = 1;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            // contentPadding: const EdgeInsets.all(0),
            insetPadding: const EdgeInsets.all(16),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Pages'),
                          value: 1,
                          groupValue: type,
                          onChanged: (value) => setState(() {
                                type = value;
                                print('Value is $value, type is $type');
                              })),
                    ),
                    Expanded(
                      child: RadioListTile(
                          title: const Text('Minutes'),
                          value: 2,
                          groupValue: type,
                          onChanged: (value) => setState(() {
                                type = value;
                                print('Value is $value, type is $type');
                              })),
                    )
                  ],
                ),
                TextFormField(
                  controller: targetController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(hintText: "Enter your goal"),
                ),
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          );
        });
      });
}
