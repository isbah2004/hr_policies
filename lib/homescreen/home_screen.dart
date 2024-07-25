import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_policies/Utils/utils.dart';
import 'package:hr_policies/authsetup/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final fireStore = FirebaseFirestore.instance.collection('doc').snapshots();
  CollectionReference urlRef = FirebaseFirestore.instance.collection('doc');

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didpop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Documents',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xfffb8c00), Color(0xffffa726)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                }).onError((error, stackTrace) {
                  Utils.showMessage(
                      context: context,
                      title: 'Error',
                      message: error.toString());
                });
              },
            ),
          ],
          elevation: 10, // Adds shadow to AppBar
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffffa726), // Bright orange color
                      ),
                    ),
                  );
                } else if (snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 3),
                    child: const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }

                return Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            Utils.urlLauncher(data['url']);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    data['name'],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  color:
                                      Color(0xffffa726), // Bright orange color
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      ),
    );
  }
}
