import 'Page AddService.dart';
import 'page category list.dart';
import '../constant/constent.dart';
import 'package:flutter/material.dart';
import '../constant/drawer.dart';

class ChoosePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Color(0xEE3264EE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: kAppBarColor,
        title: Text(
          'Home Page',
          style: kTitleAppbarStyle,
        ),
      ),
      drawer: MyDrawer(),
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/home.png'), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kBackTextColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100)),
                ),
                child: Text(
                  'Choose You Need',
                  style: kTitleText,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryListPage(),
                  ),
                ),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: kCardHomeColor),
                  margin: EdgeInsets.all(50),
                  child: Center(
                      child: Text('Veiw Service', style: kTitleCardHomeText)),
                ),
              ),

              //-------------------------------------add service card-------

              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddService(),
                  ),
                ),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: kCardHomeColor,
                      borderRadius: BorderRadius.circular(30)),
                  margin: EdgeInsets.all(50),
                  child: Center(
                      child: Text('Add Service', style: kTitleCardHomeText)),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
