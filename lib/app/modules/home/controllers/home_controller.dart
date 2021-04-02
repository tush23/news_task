import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:news_task/app/api/provider/api_handlers.dart';
import 'package:news_task/app/api/provider/api_provider.dart';
import 'package:news_task/app/constants/strings.dart';
import 'package:news_task/app/data/models/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController with StateMixin<List<Articles>> {
  var currentCountry = ''.obs;
  String pageSize = '5';
  RxList<Articles> articleList=RxList<Articles>();


  //this will search the instance of ApiProvider in memory
  ApiProvider _apiProvider = Get.find();
  var endOfListMsg=''.obs;

  //for pagination
  ScrollController scrollController;
  var pageCount = 1.obs; //page initial count

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    _getCurrentPosition();
  }

  @override
  void onReady() {
    change(null, status: RxStatus.loading());

    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        pageCount.value++;
        // print('Page Count----------------------------------------$pageCount.value}');
        getTopHeadlines(pageCount.value.toString());
      }
    });
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }

  Future<void> _getCurrentPosition() async {
    // verify permissions
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    }
    // get current position
    try {
      Position _currentPosition;
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      await _getGeolocationAddress(_currentPosition);
      getTopHeadlines(pageCount.value.toString());
    } catch (e) {
      ApiHandler().noLocationDialog(_openLocSettings);
    }
    // get address
  }

  _openLocSettings() async {
    await Geolocator.openAppSettings();
    await Geolocator.openLocationSettings();
    Future.delayed(Duration(seconds: 3), () {
      _getCurrentPosition();
      if (Get.isDialogOpen) {
        Get.back();
      }
    });
  }

  // Method to get Country/Address from position:
  _getGeolocationAddress(Position position) async {
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      print('Country-----------------------${place.isoCountryCode}');
      currentCountry.value = place.isoCountryCode;
    }
  }

  getTopHeadlines(String pageCount) {
    print('--------called------');
    Map<String, String> requestQuery = {
      'country': currentCountry.value,
      'apiKey': K_API_KEY,
      'pageSize': pageSize,
      'page': pageCount
    };
    _apiProvider.getTopHeadlines(requestQuery).then((value) {
      if (value.isOk) {
        NewsResponse _data=value.body;
        if(_data.articles.isEmpty){
          endOfListMsg.value='You have Reached End of the List';
        }
        articleList.addAll(_data.articles);
        change(articleList, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.error(value.statusText));
        if(value.status.connectionError){
          Get.defaultDialog(
              title: 'No Internet',
              onConfirm:()=> Get.back(),
              middleText: "Please check your internet connection");
        }
      }
    });
  }
  //for launching article url
  void launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
