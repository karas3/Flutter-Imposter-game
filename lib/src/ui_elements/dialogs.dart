import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String confirmButtonText;
  final String denyButtonText;

  const ConfirmationDialog({super.key,
    required this.title,
    this.description,
    required this.confirmButtonText,
    required this.denyButtonText,
  });

  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyles.dialogTitle,
      ),
      content: Text(
        description ?? "",
        textAlign: TextAlign.center,
        style: AppTextStyles.dialogDescription
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                FilledButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: Text(
                    confirmButtonText,
                    style: AppTextStyles.dialogTitle,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: Text(
                      denyButtonText,
                      style: AppTextStyles.dialogTitle,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ChangeColorDialog extends StatelessWidget {
  final Color color;

  const ChangeColorDialog({super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    Color? changedColor;

    return AlertDialog(
      actions: <Widget>[
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: ColorPicker(pickerColor: color, onColorChanged: (color) => changedColor = color)
            ),
            FilledButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                "Change color",
                style: AppTextStyles.dialogTitle
              ),
              onPressed: () {
                Navigator.of(context).pop(changedColor);
              },
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              child: OutlinedButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: Text(
                  "Cancel",
                  style: AppTextStyles.dialogTitle
                ),
                onPressed: () {
                  Navigator.of(context).pop(color);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WarningDialog extends StatelessWidget {
  final String title;
  final String? description;

  const WarningDialog({super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: AppTextStyles.dialogTitle,
      ),
      content: Text(
        description ?? "",
        textAlign: TextAlign.center,
        style: AppTextStyles.dialogDescription,
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                "Ok",
                style: AppTextStyles.dialogTitle
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}