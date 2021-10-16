import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();


  final firstCamera = cameras.first;

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(

        camera: firstCamera,
      ),
    ),
  );
}


class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key? key,
    required this.camera,
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(

      widget.camera,

      ResolutionPreset.ultraHigh,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:IconButton(
            onPressed: (){},
            icon:const Icon(
                Icons.menu
            )
        ),
        title: const Text('Camera Screen'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      extendBody: true,
      body: Container(
        padding: EdgeInsets.symmetric(),
        child: FutureBuilder<void>(

          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {

              return CameraPreview(_controller);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Stack(
          children: [
            Positioned(
              left:30,
              bottom: 20,
              child: FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: (){},
                child:const Icon(
                  Icons.camera_front
                )
              ),

            ),
            Positioned(
              right:30,
              bottom:20,
              child: FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: (){},
                child:const Icon(
                  Icons.photo
                )
              ),
            ),
            Positioned(
              bottom:20,
              left:165,
              child:FloatingActionButton(
                backgroundColor: Colors.grey,
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  try {
                    // Ensure that the camera is initialized.
                    await _initializeControllerFuture;

                    // Attempt to take a picture and get the file `image`
                    // where it was saved.
                    final image = await _controller.takePicture();

                    // If the picture was taken, display it on a new screen.
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DisplayPictureScreen(
                          // Pass the automatically generated path to
                          // the DisplayPictureScreen widget.
                          imagePath: image.path,
                        ),
                      ),
                    );
                  } catch (e) {
                    // If an error occurs, log the error to the console.
                    print(e);
                  }
                },
                child: const Icon(Icons.camera_alt),
              ),

              )
            ],
        ),

    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("show image"),
        centerTitle: true,

      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body:Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex:3,
              child:Image.file(File(imagePath)),
            ),
            const Expanded(
              flex:1,
              child:Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'The digit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              )
            )
          ],
        )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: [
          Positioned(
            right:50.0,
            bottom:30.0,
            child:FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: (){},
              child:const Icon(
                Icons.save_alt,
              )
            )

          ),
          Positioned(
            left:50.0,
            bottom:30.0,
            child:FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: (){},
              child:const Icon(
                Icons.replay,
              )
            )
          ),
          Positioned(
            left:165.0,
            bottom:30.0,
            child:FloatingActionButton(
              backgroundColor:Colors.grey ,
              onPressed:() {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.home,
              )
            )
          )
        ],
      ),
    );
  }
}