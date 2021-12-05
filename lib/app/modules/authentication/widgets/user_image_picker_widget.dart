import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_chat/app/constants/app_string.dart';

class UserImagePickerWidget extends StatefulWidget {
  final void Function(File image) onImagePick;

  const UserImagePickerWidget({
    required this.onImagePick,
    Key? key,
  }) : super(key: key);

  @override
  _UserImagePickerWidgetState createState() => _UserImagePickerWidgetState();
}

class _UserImagePickerWidgetState extends State<UserImagePickerWidget> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() => _image = File(pickedImage.path));
      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          CircleAvatar(
            radius: 40.0,
            backgroundColor: Colors.grey,
            backgroundImage: _image != null ? FileImage(_image!) : null,
          ),
          TextButton(
            onPressed: _pickImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.image,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(AppString.addImagePicked),
              ],
            ),
          ),
        ],
      );
}
