import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/src/common/constraint.dart';
import 'package:todoapp/src/models/task.dart';
import 'package:todoapp/src/repository/task_repository.dart';
import 'package:todoapp/src/routes/app_pages.dart';
import 'package:todoapp/src/widget/task_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? value = false;
  _showBottomSheetDelete(context, id) {
    showModalBottomSheet(
        context: context,
        builder: (context) => SafeArea(
                child: Container(
              child: Wrap(
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.delete),
                    title: new Text("Delete"),
                    onTap: () {
                      TaskRepository().removeTask(id);
                      Get.back();
                    },
                  )
                ],
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Get.offAllNamed(Routes.ROOT);
          },
          icon: Icon(
            Icons.list,
            color: colorPrimary,
            size: 20,
          ),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/60530946?v=4',
              ),
              radius: 16,
            ),
            SizedBox(
              width: 6.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Loan xinh xắn đáng yêu',
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text('10 tasks',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ))
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_alt_outlined,
                color: Colors.grey.shade700,
                size: 24,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.CREATE_TASK),
        backgroundColor: colorPrimary,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 25.5,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Container(
          color: Colors.white,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('tasks')
                .where('idUser',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('status', isEqualTo: 0)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.CREATE_TASK,
                          arguments:
                              Task.fromFirebase(snapshot.data!.docs[index]));
                    },
                    onLongPress: () async {
                      _showBottomSheetDelete(
                          context, snapshot.data!.docs[index].id);
                    },
                    child: TaskCard(
                      task: Task.fromFirebase(snapshot.data!.docs[index]),
                    ),
                  );
                },
              );
            },
          )),
    );
  }
}
