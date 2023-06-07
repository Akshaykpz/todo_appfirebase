import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_appfirebase/pages/ui.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

final CollectionReference donar =
    FirebaseFirestore.instance.collection('donar');

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                'No data available',
                style: TextStyle(fontSize: 20),
              ));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot<Map<String, dynamic>> donar =
                    snapshot.data!.docs[index];
                final data = donar.data();
                final name = data?['name'].toString() ?? '';
                final phone = data?['phone'].toString() ?? '';
                final group = data?['group'] ?? '';
                return Column(children: [
                  Card(
                      color: Colors.amber,
                      elevation: 2,
                      child: ListTile(
                          title: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                delete(donar.id);
                              },
                              icon: const Icon(Icons.delete)),
                          subtitle: Text(phone,
                              style: const TextStyle(
                                fontSize: 16,
                              )),
                          leading: CircleAvatar(
                            child: Text(group),
                          ))),
                ]);
              },
            );
          },
          stream:
              donar.snapshots() as Stream<QuerySnapshot<Map<String, dynamic>>>,
        ),
      ),
    );
  }
}

void delete(docid) {
  donar.doc(docid).delete();
}
