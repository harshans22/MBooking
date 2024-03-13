import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movieticket/methods/firestore_methods.dart';
import 'package:movieticket/models/moviedata.dart';
import 'package:movieticket/utils/color.dart';
import 'package:movieticket/utils/pickimage.dart';
import 'package:movieticket/widgets/multiple_image_selection(for%20admin).dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<Actor> actors = [];
  List<Actor> director = [];
  List<String> languages = [];
  List<String> type = [];
  String datepicked = "";

  Uint8List? movieposter;
  final TextEditingController _descriptioncontroller = TextEditingController();
  final TextEditingController _moviename = TextEditingController();
  final TextEditingController _languagecontroller = TextEditingController();
  final TextEditingController _typecontroller = TextEditingController();
  final TextEditingController _ratingcontroller = TextEditingController();
  final TextEditingController _censorshipcontroller = TextEditingController();
  final TextEditingController _trailerlink = TextEditingController();
  final TextEditingController _timeinhrs = TextEditingController();
  final TextEditingController _timeinmin = TextEditingController();
  bool _isloading = false;


// for adding actor
  void _addActor(Uint8List image, String name) {
    setState(() {
      actors.add(Actor(image: image, name: name));
    });
  }


// for adding director
  void _addirector(Uint8List image, String name) {
    setState(() {
      director.add(Actor(image: image, name: name));
    });
  }


// for deleting  actor
  void _removeActor(int index) {
    setState(() {
      actors.removeAt(index);
    });
  }


// for deleting  actor
  void _removedirector(int index) {
    setState(() {
      director.removeAt(index);
    });
  }


  //for posting data
  void postdata() async {
    setState(() {
      _isloading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _moviename.text,_descriptioncontroller.text,actors,director,
        languages,_timeinhrs.text,_timeinmin.text,movieposter!,type,
        _ratingcontroller.text,
        _censorshipcontroller.text,
        _trailerlink.text,datepicked
      );
      if (res == "success") {
        setState(() {
          _isloading = false;
        });
        showSnackBar("Posted", context);
        //clearImage();
      } else {
        setState(() {
          _isloading = false;
        });
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {},
        ),
        title: const Text("Post to"),
        //actions is used to specify widgets on the edge of appbar
        actions: [
          TextButton(
            // button for posting selected image
            onPressed: () {
              postdata();
            },
            child: const Text(
              "Upload",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          _isloading
              ? const LinearProgressIndicator()
              : const Padding(padding: EdgeInsets.only(top: 0)),
          const Divider(),
          TextField(
            controller: _moviename,
            decoration: const InputDecoration(
              hintText: ("Movie Name"),
            ),
            maxLines: null,
          ),
          const SizedBox(
            height: 14,
          ),
          TextField(
            controller: _descriptioncontroller,
            decoration: const InputDecoration(
              hintText: ("enter description"),
            ),
            maxLines: null,
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            height: 50 + actors.length * 60,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid, color: Colors.grey),
            ),
            child: ListView.builder(
              itemCount: actors.length + 1, // Add 1 for the "Add Actor" button
              itemBuilder: (context, index) {
                if (index == actors.length) {
                  // Add a button to add a new actor
                  return ListTile(
                    leading: TextButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                           const TextStyle(fontSize: 16),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            /// material state property can be usefull when you want to change the properties according to the state
                            Colors.blue,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          )),
                      child: const Text("Add Actor"),
                      onPressed: () {
                        _showAddActorDialog(context, false);
                      },
                    ),
                  );
                } else {
                  // Display the actor details
                  return MovieCastField(
                    actor: actors[index],
                    onDelete: () {
                      _removeActor(index);
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          //for director
          Container(
            height: 50 + director.length * 60,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              border: Border.all(style: BorderStyle.solid, color: Colors.grey),
            ),
            child: ListView.builder(
              itemCount:
                  director.length + 1, // Add 1 for the "Add Actor" button
              itemBuilder: (context, index) {
                if (index == director.length) {
                  // Add a button to add a new actor
                  return ListTile(
                    leading: TextButton(
                      style: ButtonStyle(
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(fontSize: 16),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            /// material state property can be usefull when you want to change the properties according to the state
                            Colors.blue,
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white,
                          )),
                      child: const Text("Add Director"),
                      onPressed: () {
                        _showAddActorDialog(context, true);
                      },
                    ),
                  );
                } else {
                  // Display the actor details
                  return MovieCastField(
                    actor: director[index],
                    onDelete: () {
                      _removedirector(index);
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //for langauges
          TextField(
            controller: _languagecontroller,
            decoration:
                const InputDecoration(hintText: "enter movie languages"),
            onSubmitted: (value) {
              languages.add(value);
              _languagecontroller.clear();
              
            },
          ),
          const SizedBox(
            height: 10,
          ),
          //for time
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _timeinhrs,
                  decoration:
                      const InputDecoration(hintText: "enter time in hrs"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 1,
                child: TextField(
                  controller: _timeinmin,
                  decoration:
                      const InputDecoration(hintText: "enter time in min"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          movieposter != null
              ? Stack(
                  children: [
                    Image.memory(
                      movieposter!,
                      height: 100.h,
                      width: 100.w,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(154, 17, 16, 16),
                      ),
                    ),
                    Positioned(
                        top: 10,
                        right: 35,
                        child: IconButton(
                            onPressed: () {
                              movieposter = null;
                              setState(() {});
                            },
                            icon: const Icon(
                              Icons.delete,
                              size: 50,
                            ))),
                  ],
                )

              : Row(
                  children: [
                    Text("select movie poster"),
                    IconButton(
                      onPressed: () async {
                        Uint8List image = await pickImage(ImageSource.gallery);

                        setState(() {
                          movieposter = image;
                        });
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
          //for movie type
          TextField(
            controller: _typecontroller,
            decoration: const InputDecoration(hintText: "enter movie type"),
            onSubmitted: (value) {
              type.add(value);
              _typecontroller.clear();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _ratingcontroller,
            decoration: const InputDecoration(hintText: "enter rating "),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _censorshipcontroller,
            decoration: const InputDecoration(hintText: "enter censorhip "),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: _trailerlink,
            decoration: const InputDecoration(hintText: "enter trailer link "),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2025));
              datepicked = date!.day.toString() +
                  "/" +
                  date.month.toString() +
                  "/" +
                  date.year.toString();
              print(datepicked);
              setState(() {
                
              });
            },
            child:  Column(
                    children: [
                      Text(datepicked,style:const TextStyle(color: Colors.white),),
                     const Text("select date"),
                     const Icon(Icons.calendar_month),
                    ],
                  ),
          ),
        ]),
      ),
    );
  }

  //to show actor and director dialog box

  void _showAddActorDialog(BuildContext context, bool isDirector) {
    Uint8List? _selectedImage;
    TextEditingController _nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Actor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: _selectedImage != null
                    ? Image.memory(_selectedImage!,height: 100.h,width:150.w ,fit:BoxFit.fill,)
                    : Icon(Icons.add_photo_alternate, size: 100),
                onTap: () async {
                  // Select image from gallery
                  Uint8List pickedImage = await pickImage(ImageSource.gallery);
                  if (pickedImage != null) {
                    _selectedImage = pickedImage;
                    setState(() {});
                  }
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Actor Name'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add the actor with the provided details.
                if (_selectedImage != null && _nameController.text.isNotEmpty) {
                  if (!isDirector) {
                    _addActor(_selectedImage!, _nameController.text);
                  } else {
                    _addirector(_selectedImage!, _nameController.text);
                  }

                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Please select an image and enter a name for the actor.'),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
