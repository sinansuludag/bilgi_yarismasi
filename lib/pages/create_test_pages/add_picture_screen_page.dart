import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPictureScreenPage extends StatefulWidget {
  const AddPictureScreenPage({Key? key}) : super(key: key);

  @override
  State<AddPictureScreenPage> createState() => _AddPictureScreenPageState();
}

class _AddPictureScreenPageState extends State<AddPictureScreenPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo.shade300,
        appBar: AppBar(
          backgroundColor: Colors.indigo.shade200,
          title: const Text(
            "Resim Ekle",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myImageAsset("assets/images/icons8-gallery-64.png"),
                    myIcon(),
                  ],
                ),
                const SizedBox(height: 20),

              ],
            ),
          ),
        ),
      ),
    );
  }

  TextButton myIcon() {
    return TextButton(
      onPressed: () async {
        File? result = await secimYukle(ImageSource.camera);
        if (result != null) {
          Navigator.pop(context, result);
        }
      },
      child: Container(
        width: 70,
        height: 70,
        color: Colors.indigo.shade200,
        child: Column(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              "Kamera",
              style: TextStyle(color: Colors.indigo.shade500),
            ),
          ],
        ),
      ),
    );
  }

  TextButton myImageAsset(String asset) {
    return TextButton(
      onPressed: () async {
        File? result = await secimYukle(ImageSource.gallery);
        if (result != null) {
          Navigator.pop(context, result);
        }
      },
      child: Container(
        height: 70,
        width: 70,
        color: Colors.indigo.shade200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
            Text(
              "Galeri",
              style: TextStyle(color: Colors.indigo.shade500),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> secimYukle(ImageSource source) async {
    final picker = ImagePicker();
    XFile? secilen = await picker.pickImage(source: source);
    if (secilen != null) {
      return File(secilen.path);
    }
    return null;
  }
}
