import 'package:flutter/material.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/ui/result_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 12,
          itemBuilder: (context, position) {
            return Container(
              margin:
                  const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
              child: Card(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 12),
                            child: const Text("New")),
                        Container(
                          height: 17.0,
                          width: 3,
                          color: ColorConstants.backgroundColor,
                          margin: const EdgeInsets.only(
                              left: 7.0, right: 7.0, top: 5, bottom: 5),
                        ),
                        const Text("July 23"),
                        Container(
                          margin: EdgeInsets.only(left: 100),
                          child: Text("Expires on June 23"),
                        )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 12, top: 5, bottom: 5),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Fly Deal Fare",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )),
                    Row(
                      children: [
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(
                              left: 10, top: 8, bottom: 8, right: 10),
                          child: const Text(
                              "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto"),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ResultScreen()));
                              },
                              icon: Image.asset(
                                'assets/images/forward_icon.png',
                                color: ColorConstants.iconColror,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
