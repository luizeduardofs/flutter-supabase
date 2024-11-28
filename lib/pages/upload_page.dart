import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  File? _imageFile;

  Future<void> pickeImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Page')),
      body: Center(
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!)
                : const Text('No image selected...'),
            FilledButton(
                onPressed: pickeImage, child: const Text('Pick Image')),
          ],
        ),
      ),
    );
  }
}
