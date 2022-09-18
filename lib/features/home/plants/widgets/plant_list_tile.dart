import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/screens/screens.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/event_service.dart';
import 'package:provider/provider.dart';

class PlantListTile extends StatelessWidget {
  final Plant plant;
  const PlantListTile({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    HouseholdNotifier householdNotifier = Provider.of<HouseholdNotifier>(context);
    List<Household> myHouseholds = householdNotifier.myHouseholds!;
    Household household = myHouseholds.where((household) => household.uid == plant.householdUid).first;
    return GestureDetector(
      onTap: () {
        plantNotifier.setCurrentPlant = plant;
        EventService.getCurrentPlantEvents(context);
        Navigator.push(context, MaterialPageRoute(builder: (_) => const PlantDetailScreen()));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF15CAB8), Color(0xFF109C8E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Card(
                      elevation: 5,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey[400],
                          backgroundImage: plant.photoURL != null ? CachedNetworkImageProvider(plant.photoURL!) : null,
                          child: plant.photoURL != null
                              ? null
                              : Text(
                                  plant.name[0],
                                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      plant.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white, thickness: 1),
                const Text(
                  'Actions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '- Water',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Due in 3 days',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      '- Misting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Due in 1 day',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Household',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '- ${household.name}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
