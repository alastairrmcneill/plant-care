import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/theme.dart';

class CreatePlantScreen extends StatefulWidget {
  const CreatePlantScreen({Key? key}) : super(key: key);

  @override
  State<CreatePlantScreen> createState() => _CreatePlantScreenState();
}

class _CreatePlantScreenState extends State<CreatePlantScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  String? wateringNotesText;
  String? mistingNotesText;
  String? feedingNotesText;
  List<bool> wateringDays = [false, false, false, false, false, false, false];
  List<bool> mistingDays = [false, false, false, false, false, false, false];
  List<bool> feedingDays = [false, false, false, false, false, false, false];
  List<String> recurranceOptions = ['1 week', '2 weeks', '3 weeks', '4 weeks'];
  late String wateringRecurrence;
  late String mistingRecurrence;
  late String feedingRecurrence;
  bool showMisting = false;
  bool showFood = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    wateringRecurrence = recurranceOptions[0];
    mistingRecurrence = recurranceOptions[0];
    feedingRecurrence = recurranceOptions[0];
  }

  void _handleImageFromGallery() async {
    XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  Widget _displayChatImage() {
    return GestureDetector(
      onTap: _handleImageFromGallery,
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Colors.grey[200],
        backgroundImage: _image != null ? FileImage(_image!) : null,
        child: _image == null
            ? Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Icon(
                      FontAwesomeIcons.seedling,
                      size: 40,
                      color: Colors.grey[350],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 10,
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: MyColors.appBackgroundColor,
                      ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _displayWateringDetails() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 15),
          Text('Watering'),
          WeekToggleButtons(
            isSelected: wateringDays,
            onPressed: (index) => setState(() {
              wateringDays[index] = !wateringDays[index];
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      FontAwesomeIcons.arrowsRotate,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Repeat every'),
                ],
              ),
              DropdownButton(
                value: wateringRecurrence,
                items: recurranceOptions.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    wateringRecurrence = item as String;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Notes',
            ),
            maxLines: 2,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              wateringNotesText = value?.trim();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _displayMistingDetails() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 15),
          Text('Misting (optional)'),
          WeekToggleButtons(
            isSelected: mistingDays,
            onPressed: (index) => setState(() {
              mistingDays[index] = !mistingDays[index];
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      FontAwesomeIcons.arrowsRotate,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Repeat every'),
                ],
              ),
              DropdownButton(
                value: mistingRecurrence,
                items: recurranceOptions.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    mistingRecurrence = item as String;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Notes',
            ),
            maxLines: 2,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              mistingNotesText = value?.trim();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _displayFeedingDetails() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 15),
          Text('Feeding (optional)'),
          WeekToggleButtons(
            isSelected: feedingDays,
            onPressed: (index) => setState(() {
              feedingDays[index] = !feedingDays[index];
            }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.grey[200],
                    child: const Icon(
                      FontAwesomeIcons.arrowsRotate,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Repeat every'),
                ],
              ),
              DropdownButton(
                value: feedingRecurrence,
                items: recurranceOptions.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(color: Colors.teal, fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
                onChanged: (item) {
                  setState(() {
                    feedingRecurrence = item as String;
                  });
                },
              )
            ],
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Notes',
            ),
            maxLines: 2,
            keyboardType: TextInputType.name,
            onSaved: (value) {
              feedingNotesText = value?.trim();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void submit() {
    // Check name
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    // Check selected watering days
    if (!wateringDays.contains(true)) {
      showErrorDialog(context, 'Please select a day to water your plant');
      return;
    }

    // Save plant
    PlantService.create(
      context,
      name: _nameController.text.trim(),
      image: _image,
      wateringDays: wateringDays,
      wateringRecurrence: wateringRecurrence,
      wateringNotes: wateringNotesText,
      mistingDays: mistingDays,
      mistingRecurrence: mistingRecurrence,
      mistingNotes: mistingNotesText,
      feedingDays: feedingDays,
      feedingRecurrence: feedingRecurrence,
      feedingNotes: feedingNotesText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new plant'),
        actions: [
          IconButton(
            onPressed: () => submit(),
            icon: Icon(Icons.save_rounded),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      _displayChatImage(),
                      const SizedBox(width: 8),
                      Expanded(child: PlantNameFormField(textEditingController: _nameController)),
                    ],
                  ),
                  _displayWateringDetails(),
                  showMisting ? _displayMistingDetails() : Container(),
                  showFood ? _displayFeedingDetails() : Container(),
                  Column(
                    children: [
                      showMisting
                          ? Container()
                          : ElevatedButton(
                              onPressed: () => setState(() {
                                    showMisting = true;
                                  }),
                              child: Text('Add misting')),
                      showFood
                          ? Container()
                          : ElevatedButton(
                              onPressed: () => setState(() {
                                showFood = true;
                              }),
                              child: Text('Add food'),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
