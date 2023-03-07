import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/ui/mulit_city_screen.dart';
import 'package:fly_deal_fare/ui/oneway_screen.dart';
import 'package:fly_deal_fare/ui/round_trip.dart';
import 'package:fly_deal_fare/utils/diamensions.dart';

class Flights extends StatefulWidget {
  const Flights({Key? key}) : super(key: key);

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        title: const Text(
          'Tab bar',
        ),
      ),
      body: Container(
        color: ColorConstants.backgroundColor,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // give the tab bar a height [can change hheight to preferred height]
            Container(
              height: 35,
              width: 320,
              decoration: BoxDecoration(
                color: ColorConstants.whitecolr,
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25.0,
                  ),
                  color: ColorConstants.greencolor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                tabs: const [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'One Way',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Round Trip',
                  )

                  // Tab(
                  //   text: 'Multi City',
                  // )
                ],
              ),
            ),
            // tab bar view here
            SizedBox(height: Diamensions.height10,),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [OneWay(), RoundTrip()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
