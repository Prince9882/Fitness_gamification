import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("HomeScreen"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  addUserInfo(UserInfoModel(
                    name: "Henry",
                    age: 21,
                    location: "London",
                  ));
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Add Info",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              StreamBuilder<List<UserInfoModel>>(
                stream: fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(child: Text("No Data Available"));
                  }
                  final userList = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                        children: userList!.map((user) {
                          return ListTile(
                            leading: GestureDetector(
                              onTap: () {
                                removeUser(user.docId!);
                              },
                              child: Icon(Icons.delete),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                updateUserInfo(
                                  UserInfoModel(
                                    docId: user.docId,
                                    name: "John Wick",
                                    location: "Pakistan",
                                  ),
                                );
                              },
                              child: Icon(Icons.update),
                            ),
                            title: Text(user.name!),
                            subtitle: Text(user.location!),
                          );
                        }).toList()),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, "/login");
                  print("Logged out successfully");
                },
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Stream<List<UserInfoModel>> fetchUserData() {
    final userCollection = FirebaseFirestore.instance.collection("users");

    return userCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserInfoModel.fromSnapshot(doc)).toList());
  }

  void addUserInfo(UserInfoModel userInfo) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    String docId = userCollection.doc().id;

    final newUser = UserInfoModel(
      name: userInfo.name,
      age: userInfo.age,
      location: userInfo.location,
      docId: docId,
    ).toMap();

    userCollection.doc(docId).set(newUser);
  }

  void updateUserInfo(UserInfoModel userInfo) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    final updatedData = UserInfoModel(
      name: userInfo.name,
      docId: userInfo.docId,
      location: userInfo.location,
      age: userInfo.age,
    ).toMap();

    userCollection.doc(userInfo.docId).update(updatedData);
  }

  void removeUser(String docId) {
    final userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(docId).delete();
  }
}

class UserInfoModel {
  final String? name;
  final String? location;
  final int? age;
  final String? docId;

  UserInfoModel({this.docId, this.name, this.location, this.age});

  static UserInfoModel fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return UserInfoModel(
      name: snapshot['name'],
      location: snapshot['location'],
      age: snapshot['age'],
      docId: snapshot['docId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "age": age,
      "docId": docId,
      "location": location,
    };
  }
}
