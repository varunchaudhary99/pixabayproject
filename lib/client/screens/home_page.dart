import 'dart:developer';

import 'package:flutter/material.dart';

import '../../api/data_api.dart';
import '../../api/get_data_model.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/popup.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<UserModel> userData = [];
// Initial like count



@override
void initState() {
  getData();
  super.initState();
}



getData() async {
    appLoader.show(context);
    final rsp = ImageGetApi().get();
    rsp.then((value) {
      log(value.toString());
      try {
        setState(() {
          userData = value;
          print(value);
          // print("data show opposite gender${oppositegenderMataches}");
        });
        appLoader.hide();
      } catch (e) {
        setState(() {
          // loadingData = false;
        });
      }
    }).onError((error, stackTrace) {
      showTost(error);
      appLoader.hide();
    }).whenComplete(() {
      appLoader.hide();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Center(child: Text('User Image')),
       ),
      body: SingleChildScrollView(
        child:   GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            // number of items in each row
            mainAxisSpacing: 20.0, // spacing between rows
            crossAxisSpacing: 20.0, // spacing between columns
          ),
          padding: EdgeInsets.all(8.0), // padding around the grid
          itemCount: userData.length,//subcreptionplan.length,

          ///items.length, // total number of items
          itemBuilder: (context, index) {
    if (userData.isNotEmpty) {
    var user = userData[index];
    {
      return UserTile(
          context,
          user);
    }}})));}

  }

Widget UserTile(BuildContext context, UserModel user) {
  return GestureDetector(
    onTap:(){}, // Increment likes when tapped
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(
            user.userImageURL,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            color: Colors.black54, // Semi-transparent background
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  'Likes: ${user.likes}', // Display like count
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}