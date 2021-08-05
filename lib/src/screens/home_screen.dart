import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:todoapp/src/common/constrant.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 4.0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Feather.align_left,
            color: colorPrimary,
            size: 24.0,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://avatars.githubusercontent.com/u/60530946?v=4'),
              radius: 16.0,
            ),
            SizedBox(width: 6.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hồng Vinh',
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  '10 Tasks',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Feather.filter,
              color: Colors.grey.shade700,
              size: 24.0,
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 10.0),
          itemCount: 10,
          itemBuilder: (context, index) {
            return _buildTaskCard(context);
          },
        ),
      ),
    );
  }

  Widget _buildTaskCard(context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0, left: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(12.0),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 48.0,
            width: 6.0,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(12.0),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Học Flutter 9h tối',
                style: TextStyle(
                  color: colorPrimary,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'Học tập',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                '9:00 PM - 05/08/2021',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
