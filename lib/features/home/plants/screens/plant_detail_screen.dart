import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plant_care/features/home/plants/widgets/widgets.dart';
import 'package:plant_care/general/models/models.dart';
import 'package:plant_care/general/notifiers/notifiers.dart';
import 'package:plant_care/general/services/services.dart';
import 'package:plant_care/general/widgets/widgets.dart';
import 'package:plant_care/support/constants.dart';
import 'package:provider/provider.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PlantDetailScreen extends StatefulWidget {
  const PlantDetailScreen({Key? key}) : super(key: key);

  @override
  State<PlantDetailScreen> createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlantNotifier plantNotifier = Provider.of<PlantNotifier>(context);
    Plant plant = plantNotifier.currentPlant!;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: MultiSliver(
              children: [
                SliverAppBar(
                  expandedHeight: 200,
                  flexibleSpace: GestureDetector(
                    onTap: () {
                      if (plant.photoURL != null) {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => FullScreenImage(photoURL: plant.photoURL!)));
                      }
                    },
                    child: FlexibleSpaceBar(
                      title: Text(plant.name, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
                      background: plant.photoURL == null
                          ? null
                          : CachedNetworkImage(
                              imageUrl: plant.photoURL!,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) => CircularProgressIndicator(value: downloadProgress.progress),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                    ),
                  ),
                  floating: true,
                  snap: false,
                  pinned: true,
                  actions: [
                    PopupMenuButton(
                      icon: Icon(Icons.more_vert_rounded),
                      onSelected: (value) async {
                        if (value == MenuItems.item1) {
                          print("Edit");
                        } else if (value == MenuItems.item2) {
                          await PlantService.removePlantFromHousehold(context, plant: plant);
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: MenuItems.item1,
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: MenuItems.item2,
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      controller: tabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Theme.of(context).primaryColor,
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      labelStyle: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.w300, fontSize: 14),
                      tabs: const [
                        Tab(
                          text: 'Overview',
                        ),
                        Tab(text: 'Schedule'),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: const [
            OverviewTab(),
            CalendarTab(),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
