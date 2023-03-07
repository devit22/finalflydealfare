import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fly_deal_fare/models/Country.dart';
import 'package:fly_deal_fare/models/LoggedInUser.dart';
import 'package:fly_deal_fare/models/RegisterResponse.dart';
import 'package:fly_deal_fare/models/ReturnRespons.dart';
import 'package:fly_deal_fare/models/blogsmodel/BlogList.dart';
import 'package:fly_deal_fare/models/output.dart';
import 'package:fly_deal_fare/models/pricemodel/PriceModel.dart';
import 'package:fly_deal_fare/models/referralmodels/ReferralUsers.dart';
import 'package:fly_deal_fare/models/referralmodels/Output.dart' as Referr;
import 'package:fly_deal_fare/models/modelloginwithid/Output.dart' as LoggedINwithuserdi;
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserApiService {
  static String BASE_URL = "http://192.168.1.82/flydealfare/";
  static String BASE_URL2 = "https://flydealfare.com/API/";

  static Future<List<Output>> getsuggestionairport(String queryy) async {
    final url = Uri.parse("https://flydealfare.com/API/airport/list/");
    final response = await http.get(url);
    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => Output.fromJson(json)).where((users) {
        final namelower = users.name!.toLowerCase();
        final codelower = users.code!.toLowerCase();
        final query = queryy.toLowerCase();
        return codelower.startsWith(query) || namelower.startsWith(query);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Output>> getupdatedairportlist(String queryy) async {
    final url = Uri.parse("https://flydealfare.com/API/a/list/$queryy");
    final response = await http.get(url);
    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => Output.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List<Country>> getCountriesList(String queryy) async {
    final url = Uri.parse("https://flydealfare.com/API/country/list/");
    final response = await http.get(url);

    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => Country.fromJson(json)).where((users) {
        final namelower = users.name!.toLowerCase();
        final query = queryy.toLowerCase();
        return namelower.startsWith(query);
      }).toList();
    } else {
      throw Exception();
    }
  }


  static Future<RegisterResponse> getResgisterelinkList(String email,
      String password, String name, String mobile, String source) async {
    final url = Uri.parse(
        "https://flydealfare.com/API/sign_up.php?email=$email&name=$name&password=$password&mobile=$mobile&source=$source");
    final response = await http.get(url);
    final RegisterResponse registerresposn = RegisterResponse.fromJson(
        json.decode(response.body));
    if (response.statusCode == 200) {
      return registerresposn;
    } else {
      throw Exception();
    }
  }


  static Future<http.Response> getLoggedInList(String email,
      String password,BuildContext context) async {
    final url = Uri.parse(
        "https://flydealfare.com/API/login.php?username=$email&password=$password");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }

  static Future<ReturnRespons> submitpersondata(String descode, String descity,
      String depcode, String depcity,
      String inserdata, String passendinfo, String email, String mobile,
      String name) async {
    final url = Uri.parse("${BASE_URL}secretdeal.php");
    final respons = await http.post(url, body: {
      "depcity": depcity,
      "depcode": depcode,
      "descity": descity,
      "descode": descode,
      "insertDate": inserdata,
      "passenger": passendinfo,
      "email": email,
      "mobile": mobile,
      "name": name
    });

    final ReturnRespons returnRespons = ReturnRespons.fromJson(
        jsonDecode(respons.body.toString()));

    if (respons.statusCode == 200) {
      return returnRespons;
    } else {
      throw Exception();
    }
  }

  static Future<ReturnRespons> userupdatedata(String id, String email,
      String address, String name, String mobile) async {
    final url = Uri.parse("${BASE_URL}updatedata.php");
    final respons = await http.post(url, body: {
      "name": name,
      "email": email,
      "mobile": mobile,
      "address": address,
      "id": id,
    });

    final ReturnRespons returnRespons = ReturnRespons.fromJson(
        jsonDecode(respons.body.toString()));

    if (respons.statusCode == 200) {
      return returnRespons;
    } else {
      throw Exception();
    }
  }


  static Future<List<BlogList>> getblogs() async {
    final url = Uri.parse("http://flydealfare.com/API/blog.php");
    final response = await http.get(url);
    var data = jsonDecode(response.body.toString());
    List<BlogList> bloglist = [];
    if (response.statusCode == 200) {
      for (Map i in data) {
        bloglist.add(BlogList.fromJson(i));
      }
      return bloglist;
    } else {
      throw Exception();
    }
  }


  static Future<List<int>> getpricelist(String date, String triptype) async {
    List<int> pricelist = [];
    final url = Uri.parse(
        "https://flydealfare.com/API/special_price.php?date=$date");

    final response = await http.get(url);
    var data = jsonDecode(response.body.toString());
    final PriceModel priceModel = PriceModel.fromJson(data);

    if (response.statusCode == 200) {
      if (triptype == "one") {
        var min = int.parse(priceModel.owFrom!);
        var max = int.parse(priceModel.owTo!);

        Random random = new Random();
        for (int i = 0; i < 10; i++) {
          int price = min + random.nextInt(max - min);
          pricelist.add(price);
        }
        return pricelist;
      } else {
        var min = int.parse(priceModel.rtFrom!);
        var max = int.parse(priceModel.rtTo!);

        Random random = new Random();
        for (int i = 0; i < 10; i++) {
          int price = min + random.nextInt(max - min);
          pricelist.add(price);
        }
        return pricelist;
      }
    } else {
      throw Exception();
    }
  }


  static Future<RegisterResponse> sendreferData(String UserId,
      String depcity,
      String descity, String depdate,String email,String mobile,String name
      ) async {

    final url = Uri.parse(
    "https://flydealfare.com/API/refer_form.php?UserId=$UserId&depcity=$depcity&descity=$descity&depdate=$depdate&email=$email&mobile=$mobile&name=$name&status=0");
    final response = await http.get(url);
    final RegisterResponse registerResponse = RegisterResponse.fromJson(jsonDecode(response.body.toString()));
    if (response.statusCode == 200) {
    return registerResponse;
    } else {
    throw Exception();
    }
  }


  static Future<List<Referr.Output>> getReferredlist(String Userid) async {
    final url = Uri.parse("https://flydealfare.com/API/refer/list/$Userid");
    final response = await http.get(url);
List<Referr.Output>  referredlist = [];
    ReferralUsers referralUsers  = ReferralUsers.fromJson(json.decode(response.body));
    if (response.statusCode == 200) {
      referralUsers.output!.forEach((element) {
        referredlist.add(element);
      });
      return referredlist;
    } else {
      throw Exception();
    }
  }

  static Future<RegisterResponse> submitsecretdata(
     String UserId, String depcity, String descity,String typeOfClass,String depdate,String returndate,String adultcount,String childcount,String infantcount,String email,String mobile,String name,String triptype
      ) async {
    final url = Uri.parse("https://flydealfare.com/API/secret_deal.php?UserId=$UserId&depcity=$depcity&descity=$descity&typeOfClass=$typeOfClass&depdate=$depdate&returndate=$returndate&adultcount=$adultcount&childcount=$childcount&infantcount=$infantcount&email=$email&mobile=$mobile&name=$name&triptype=$triptype");
    final response = await http.get(url);
    final RegisterResponse registerResponse = RegisterResponse.fromJson(jsonDecode(response.body.toString()));
    if (response.statusCode == 200) {
      return registerResponse;
    } else {
      throw Exception();
    }
  }


  static Future<List<LoggedINwithuserdi.Output>> getuserlistwithuserid(String UserId) async {
    final url = Uri.parse("https://flydealfare.com/API/user/$UserId");
    final response = await http.get(url);
    final responsdata = json.decode(response.body);
    if (response.statusCode == 200) {
      final List users = responsdata['output'];
      return users.map((json) => LoggedINwithuserdi.Output.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }
}
