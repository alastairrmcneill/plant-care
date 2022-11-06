import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_care/features/home/households/widgets/widgets.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/theme.dart';
import 'package:provider/provider.dart';

class CreatePlantScreenTest extends StatefulWidget {
  final Plant? plant;
  const CreatePlantScreenTest({Key? key, this.plant}) : super(key: key);

  @override
  State<CreatePlantScreenTest> createState() => _CreatePlantScreenTestState();
}

class _CreatePlantScreenTestState extends State<CreatePlantScreenTest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _wateringNotesController = TextEditingController();
  TextEditingController _mistingNotesController = TextEditingController();
  TextEditingController _feedingNotesController = TextEditingController();
  String wateringNotesText = "";
  String mistingNotesText = "";
  String feedingNotesText = "";
  List<bool> wateringDays = [false, false, false, false, false, false, false];
  List<bool> mistingDays = [false, false, false, false, false, false, false];
  List<bool> feedingDays = [false, false, false, false, false, false, false];
  List<String> recurranceOptions = ['1 week', '2 weeks', '3 weeks', '4 weeks'];
  late String wateringRecurrence;
  late String mistingRecurrence;
  late String feedingRecurrence;
  bool showMisting = false;
  bool showFood = false;
  int? householdIndex;
  String? householdSelected;
  List<Household> households = [];
  File? _image;

  @override
  void initState() {
    super.initState();

    if (widget.plant != null) {
      // editing plant
      _nameController.text = widget.plant!.name;
      wateringDays = List<bool>.from(widget.plant!.wateringDetails[PlantFields.days] as List<dynamic>);
      mistingDays = List<bool>.from(widget.plant!.mistingDetails[PlantFields.days] as List<dynamic>);
      showMisting = mistingDays.contains(true);
      feedingDays = List<bool>.from(widget.plant!.feedingDetails[PlantFields.days] as List<dynamic>);
      showFood = feedingDays.contains(true);

      wateringRecurrence = widget.plant!.wateringDetails[PlantFields.recurrence] as String;
      mistingRecurrence = widget.plant!.mistingDetails[PlantFields.recurrence] as String;
      feedingRecurrence = widget.plant!.feedingDetails[PlantFields.recurrence] as String;

      _wateringNotesController.text = widget.plant!.wateringDetails[PlantFields.notes] as String;
      _mistingNotesController.text = widget.plant!.mistingDetails[PlantFields.notes] as String;
      _feedingNotesController.text = widget.plant!.feedingDetails[PlantFields.notes] as String;
    } else {
      // Creating new plant
      wateringRecurrence = recurranceOptions[0];
      mistingRecurrence = recurranceOptions[0];
      feedingRecurrence = recurranceOptions[0];
    }
  }

  void _handleImageFromGallery() async {
    XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _image = File(imageFile.path);
      });
    }
  }

  Widget _displayPlantImage() {
    if (widget.plant == null) {
      return GestureDetector(
        onTap: _handleImageFromGallery,
        child: CircleAvatar(
          radius: 35,
          backgroundColor: Colors.grey[200],
          backgroundImage: _image == null ? null : FileImage(_image!),
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
    } else {
      return GestureDetector(
        onTap: _handleImageFromGallery,
        child: CircleAvatar(
          radius: 35,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: _image == null
                      ? CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: widget.plant!.photoURL != null ? CachedNetworkImageProvider(widget.plant!.photoURL!) : null,
                          child: widget.plant!.photoURL != null
                              ? null
                              : Text(
                                  widget.plant!.name[0],
                                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                                ),
                        )
                      : CircleAvatar(
                          radius: 35,
                          backgroundImage: FileImage(_image!),
                        )),
              const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 10,
                  child: Icon(
                    Icons.edit,
                    size: 12,
                    color: MyColors.appBackgroundColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _displayHouseholdDetails(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: false);
    households = householdNotifier.myHouseholds!;

    List<String> items = [];
    if (households.isNotEmpty) {
      for (var household in households) {
        items.add(household.name);
      }
    }
    String? householdSelected;

    // If editing a plant
    if (widget.plant != null) {
      if (households.isNotEmpty) {
        for (var household in households) {
          if (household.uid == widget.plant!.householdUid) {
            householdSelected = household.name;
          }
        }
      }
    }

    Widget button = TextButton(
      onPressed: () {
        showCreateHouseholdDialog(
          context,
          body: 'Please enter the name of the household:',
          hintText: 'Household name',
          function: (name) async {
            await HouseholdService.create(context, name: name);
            await HouseholdDatabase.readMyHouseholds(context);
          },
        );
      },
      child: Text(households.isEmpty ? 'New Household' : 'New'),
    );

    return Column(
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            households.isEmpty
                ? Expanded(child: button)
                : SizedBox(
                    width: 70,
                    child: button,
                  ),
            const SizedBox(width: 8),
            households.isEmpty
                ? Container()
                : Expanded(
                    flex: 1,
                    child: DropdownButtonFormField(
                      hint: Text('Household'),
                      value: householdSelected,
                      items: items
                          .map((household) => DropdownMenuItem(
                                value: household,
                                child: Text(
                                  household,
                                  style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w500),
                                ),
                              ))
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                          householdSelected = item as String;
                        });
                      },
                      onSaved: (value) {
                        householdIndex = items.indexOf(value as String);
                      },
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Widget _displayWateringDetails(BuildContext context) {
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
            controller: _wateringNotesController,
            decoration: const InputDecoration(
              hintText: 'Notes',
            ),
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              wateringNotesText = value?.trim() ?? "";
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _displayMistingDetails(BuildContext context) {
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
            controller: _mistingNotesController,
            decoration: const InputDecoration(
              hintText: 'Notes',
            ),
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              mistingNotesText = value?.trim() ?? "";
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _displayFeedingDetails(BuildContext context) {
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
            controller: _feedingNotesController,
            decoration: const InputDecoration(
              hintText: 'Notes',
            ),
            maxLines: 2,
            textCapitalization: TextCapitalization.sentences,
            onSaved: (value) {
              feedingNotesText = value?.trim() ?? "";
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void submit(BuildContext context) {
    // Check name
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    if (householdIndex == null || householdIndex == -1) {
      showErrorDialog(context, 'Please select a household to add this plant to');
      return;
    }
    // Check selected watering days
    if (!wateringDays.contains(true)) {
      showErrorDialog(context, 'Please select a day to water your plant');
      return;
    }

    if (widget.plant == null) {
      // Save plant
      PlantService.create(
        context,
        household: households[householdIndex!],
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
    } else {
      // Update plant
      PlantService.updatePlant(
        context,
        originalPlant: widget.plant!,
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
  }

  @override
  Widget build(BuildContext context) {
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: widget.plant == null ? Text('Add new plant') : Text('Edit'),
        actions: [
          IconButton(
            onPressed: () => submit(context),
            icon: Icon(
              Icons.save_rounded,
            ),
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
                      _displayPlantImage(),
                      const SizedBox(width: 8),
                      Expanded(child: PlantNameFormField(textEditingController: _nameController)),
                    ],
                  ),
                  _displayHouseholdDetails(context),
                  _displayWateringDetails(context),
                  showMisting ? _displayMistingDetails(context) : Container(),
                  showFood ? _displayFeedingDetails(context) : Container(),
                  showMisting
                      ? Container()
                      : SizedBox(
                          width: 150,
                          child: ElevatedButton(
                              onPressed: () => setState(() {
                                    showMisting = true;
                                  }),
                              child: const Text('Add misting')),
                        ),
                  showFood
                      ? Container()
                      : SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () => setState(() {
                              showFood = true;
                            }),
                            child: const Text('Add food'),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
