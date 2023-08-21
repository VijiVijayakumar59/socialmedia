// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../user/screens/user_profile.dart';

List<dynamic> availableUser = [];
List<dynamic> filteredUser = [];

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  filterUsers(value);
                },
                decoration: InputDecoration(
                  hintText: "Search Here",
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear_rounded),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('name', isEqualTo: searchController.text.trim())
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        final data = snapshot.data?.docs;
                        log('Data received:$data');

                        return data!.isEmpty
                            ? const Center(child: Text("User not found"))
                            : ListView.builder(
                                //  physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  final DocumentSnapshot userSnap = data[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 67,
                                          height: 67,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            shape: BoxShape.rectangle,
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Colors.red,
                                                Colors.yellow
                                              ],
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              width: 65,
                                              height: 65,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                shape: BoxShape.rectangle,
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      userSnap['image']),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              log(userSnap['following']
                                                  .toString());
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    UserProfile(
                                                  name: userSnap['name'],
                                                  image: userSnap['image'],
                                                  profession:
                                                      userSnap['profession'],
                                                  posts: userSnap['posts'],
                                                  followers:
                                                      userSnap['followers'],
                                                  following:
                                                      userSnap['following'],
                                                  email: userSnap['email'],
                                                  id: userSnap['id'],
                                                ),
                                              ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userSnap['name'],
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16),
                                                ),
                                                Text(
                                                  userSnap['profession'],
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return const SnackBar(content: Text("User not found"));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void filterUsers(String query) {
    setState(() {
      filteredUser = availableUser.where((doc) {
        String name = doc.data()['name'].toLowerCase();
        String searchLower = query.toLowerCase();
        log(searchLower);
        return name.contains(searchLower);
      }).toList();
    });
  }
}
