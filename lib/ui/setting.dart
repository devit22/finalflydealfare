import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fly_deal_fare/colors_class/colors_class.dart';
import 'package:fly_deal_fare/models/Country.dart';
import 'package:fly_deal_fare/models/states.dart';
import 'package:fly_deal_fare/userapiservices/user_api_services.dart';

import 'package:http/http.dart' as http;

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String? countryValueg;
  String? stateValueg;
  String? cityValueg;
  bool isPressed = false;
  bool isstatePressed = false;
  String? countrySuggestion;
  String? statesuggestion;
  String? countryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('country picker'),
        toolbarHeight: 0,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 5),
              child: TypeAheadField<Country?>(
                hideSuggestionsOnKeyboardHide: true,
                textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(color: ColorConstants.iconColror),
                    controller: TextEditingController(
                        text: (isPressed) ? countrySuggestion : ""),
                    decoration: const InputDecoration(
                        hintText: "min 3 char of Country",
                        hintStyle: TextStyle(color: ColorConstants.iconColror),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.iconColror, width: 2.0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.iconColror, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstants.iconColror, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorConstants.iconColror, width: 2.0)),
                        prefixIcon: Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: ColorConstants.iconColror,
                        ))),
                suggestionsCallback: UserApiService.getCountriesList,
                itemBuilder: (context, Country? suggestion) {
                  final user = suggestion;
                  return Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          child: Text(
                            user!.name!,
                            style: const TextStyle(
                                fontSize: 19, color: ColorConstants.iconColror),
                          )),
                    ],
                  );
                },
                minCharsForSuggestions: 3,
                noItemsFoundBuilder: (context) => Container(
                  height: 80,
                  child: const Center(
                    child: Text(
                      'No user found',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                loadingBuilder: (context) => Container(
                  height: 80,
                  child: const Center(
                    child: Text(
                      'Loading....',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                onSuggestionSelected: (Country? suggestion) {
                  final user = suggestion!;
                  setState(() {
                    isPressed = true;
                    countrySuggestion = user.name!;
                    countryId = user.id;
                  });
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 5),
              child: TypeAheadField<States?>(
                hideSuggestionsOnKeyboardHide: true,
                textFieldConfiguration: TextFieldConfiguration(
                    style: const TextStyle(color: ColorConstants.iconColror),
                    controller: TextEditingController(
                        text: (isstatePressed) ? statesuggestion : ""),
                    decoration: const InputDecoration(
                      hintText: "min 3 char of States",
                      hintStyle: TextStyle(color: ColorConstants.iconColror),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.iconColror, width: 2.0),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ColorConstants.iconColror, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.iconColror, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: ColorConstants.iconColror, width: 2.0)),
                      prefixIcon: Icon(
                        Icons.arrow_drop_down_circle_outlined,
                        color: ColorConstants.iconColror,
                      ),
                    )),
                suggestionsCallback: getStateList,
                itemBuilder: (context, States? suggestion) {
                  final user = suggestion;
                  return Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 5, top: 3, bottom: 3),
                          child: Text(
                            user!.name!,
                            style: const TextStyle(
                                fontSize: 19, color: ColorConstants.iconColror),
                          )),
                    ],
                  );
                },
                minCharsForSuggestions: 3,
                noItemsFoundBuilder: (context) => Container(
                  height: 80,
                  child: const Center(
                    child: Text(
                      'No user found',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                loadingBuilder: (context) => Container(
                  height: 80,
                  child: const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
                onSuggestionSelected: (States? suggestion) {
                  final user = suggestion!;
                  setState(() {
                    isstatePressed = true;
                    statesuggestion = user.name!;
                  });
                },
              ),
            ),
            //Depart Date value
          ],
        ),
      ),
    );
  }

  Future<List<States>> getStateList(String queryy) async {
    final url = Uri.parse("https://flydealfare.com/API/state/list/$countryId");
    final response = await http.get(url);
    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => States.fromJson(json)).where((users) {
        final namelower = users.name!.toLowerCase();
        final query = queryy.toLowerCase();
        return namelower.startsWith(query);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
