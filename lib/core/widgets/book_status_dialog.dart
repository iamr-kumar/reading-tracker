import 'package:flutter/material.dart';
import 'package:reading_tracker/core/type_defs.dart';
import 'package:reading_tracker/utils/show_snackbar.dart';

Widget showBookStatusDialog(
    {required BuildContext context,
    required int page,
    required TextEditingController progressController,
    required int status,
    required Function updateStatus,
    bool isNew = true,
    required VoidCallback onComplete}) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    insetPadding: const EdgeInsets.all(16),
    contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
    title: const Text('What\'s your current progress?'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...BookStatus.values.map((value) {
          return RadioListTile(
              title: Text(describeStatusEnum(value)),
              value: value.index,
              groupValue: status,
              onChanged: isNew
                  ? value.index <= 1
                      ? (value) => updateStatus(value)
                      : null
                  : (value) => updateStatus(value));
        }).toList(),
        status == 1
            ? TextFormField(
                controller: progressController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Pages read of $page'),
              )
            : const SizedBox(),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              if (status == 1) {
                int progress = int.parse(progressController.text);
                if (progress > page) {
                  return showSnackBar(
                      context, 'Progress cannot be more than page');
                }
              }

              Navigator.of(context).pop();
              onComplete.call();
            },
            child: const Text('Save'),
          ),
        ),
      ],
    ),
  );
}
