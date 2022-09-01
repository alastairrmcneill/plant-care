import 'dart:io';

import 'package:customtogglebuttons/customtogglebuttons.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/services/plant_service.dart';
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
  List<bool> wateringSelectedDays = [false, false, false, false, false, false, false];
  List<bool> mistingSelectedDays = [false, false, false, false, false, false, false];
  List<bool> feedingSelectedDays = [false, false, false, false, false, false, false];
  List<String> recurranceOptions = ['1 week', '2 weeks', '3 weeks', '4 weeks'];
  late String wateringRecurrance;
  late String mistingRecurrance;
  late String feedingRecurrance;
  bool showMisting = false;
  bool showFood = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    wateringRecurrance = recurranceOptions[0];
    mistingRecurrance = recurranceOptions[0];
    feedingRecurrance = recurranceOptions[0];
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
            isSelected: wateringSelectedDays,
            onPressed: (index) => setState(() {
              wateringSelectedDays[index] = !wateringSelectedDays[index];
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
                value: wateringRecurrance,
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
                    wateringRecurrance = item as String;
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
            isSelected: mistingSelectedDays,
            onPressed: (index) => setState(() {
              mistingSelectedDays[index] = !mistingSelectedDays[index];
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
                value: mistingRecurrance,
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
                    mistingRecurrance = item as String;
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
            isSelected: feedingSelectedDays,
            onPressed: (index) => setState(() {
              feedingSelectedDays[index] = !feedingSelectedDays[index];
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
                value: feedingRecurrance,
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
                    feedingRecurrance = item as String;
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
    if (!wateringSelectedDays.contains(true)) {
      showErrorDialog(context, 'Please select a day to water your plant');
      return;
    }

    // Save plant
    PlantService.create(context, name: _nameController.text.trim(), image: _image);
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
