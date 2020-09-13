import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  @override
  _ProfileImageState createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File pickedImage;

  Future<void> _pickImage() async {
    ImageSource choice = ImageSource.gallery;
    await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Choose image'),
              content: Text('Gallery or camera'),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    choice = ImageSource.camera;
                  },
                  child: Text('Camera'),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    choice = ImageSource.gallery;
                  },
                  child: Text('gallery'),
                )
              ],
            ));
    final pickedFile =
        await ImagePicker().getImage(source: choice, maxWidth: 600);
    setState(() {
      pickedImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage: pickedImage != null ? FileImage(pickedImage) : null,
        ),
        FlatButton.icon(
            color: Theme.of(context).primaryColor,
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Add profile image'))
      ],
    );
  }
}
