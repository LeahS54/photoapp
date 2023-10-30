import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:themed/themed.dart';

class MultipleImageSelector extends StatefulWidget {
  const MultipleImageSelector({super.key});

  @override
  State<MultipleImageSelector> createState() => _MultipleImageSelectorState();
}

class _MultipleImageSelectorState extends State<MultipleImageSelector> {
  List<File> selectedImages = [];
  final picker = ImagePicker();
  List<XFile> xfilePick = [];

  bool imageSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Improver'),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
              child: const Text('Select Image from Gallery '),
              onPressed: () {
                getImages();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple)),
              child: const Text('Select Image from Camera '),
              onPressed: () {
                getImagesFromCamera();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                "All Photos: ",
                textScaleFactor: 2,
                style: TextStyle(color: Colors.purple),
              ),
            ),
            Expanded(
              child: SizedBox(
                // width: 300.0,
                child: selectedImages.isEmpty
                    ? const Center(child: Text('No photos selected'))
                    : GridView.builder(
                        itemCount: selectedImages.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                imageSelected = !imageSelected;
                              });
                            },
                            child: Center(
                              child: kIsWeb
                                  ? ChangeColors(
                                      hue: 0.55,
                                      brightness: 1,
                                      saturation: 0.8,
                                      child: Image.network(
                                        selectedImages[index].path,
                                        colorBlendMode: BlendMode.clear,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    )
                                  : Image.file(
                                      selectedImages[index],
                                      colorBlendMode: BlendMode.clear,
                                      filterQuality: FilterQuality.high,
                                    ),
                            ),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1800, maxWidth: 1600);

    xfilePick.clear();
    xfilePick.addAll(pickedFile);

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future getImagesFromCamera() async {
    final pickedCameraFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 800,
        maxWidth: 600);
    xfilePick.clear();
    xfilePick.add(pickedCameraFile!);
    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(File(xfilePick[i].path));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }
}
