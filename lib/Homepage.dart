import 'package:blood_donation/Homescreen.dart';
import 'package:blood_donation/editingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference donorsCollection =
      FirebaseFirestore.instance.collection('donor');

      void donordelet(docId){
        donorsCollection.doc(docId).delete();
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blood Donation"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
      body: StreamBuilder(
        stream:donorsCollection.orderBy("name").snapshots(),
       builder: (context, AsyncSnapshot snapshot) {
         if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot donorsnap=snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 80,
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 180, 179, 179),
                      blurRadius: 10,
                      spreadRadius: 15
                    )
                  ]
                 ),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                          child:  CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 30,
                              child: Text(donorsnap["bloodgroup"],
                              style: const TextStyle(fontSize: 30),),
                          ),
                         ),
                       ),
                       Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(donorsnap["name"],
                          style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text(donorsnap["phone"].toString(),
                          style: const TextStyle(fontSize: 18),),
                         
                        ],
                       ),
                       IconButton(onPressed: () { 
                        Navigator.pushNamed(context, '/update',arguments: {
                          "name":donorsnap["name"],
                          "phone":donorsnap["phone"].toString(),
                          "bloodgroup":donorsnap["bloodgroup"],
                          "id":donorsnap.id,
                        });
                       }, icon: const Icon(Icons.edit),
                       iconSize: 30,
                       color: Colors.blue,
                       ),
                          IconButton(onPressed: () { 
                            donordelet(donorsnap.id);
                          }, icon: const Icon(Icons.delete),
                          iconSize: 30,
                          color: Colors.redAccent,
                          ),
                  ]),
                ),
              );

            },);
         }
         return Container();
       },),
    );
  }
}
