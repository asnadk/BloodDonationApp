// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CollectionReference donorsCollection =
      FirebaseFirestore.instance.collection('donor');
adddoners(){
  final data={"name":nameController.text, "phone": phoneController.text, "bloodgroup": selectedgroup };
  donorsCollection.add(data);
}


  final blood_group = ["A+", "A-", 'B-', 'B+', 'O+', 'O-', 'AB-', "AB+"];
  String? selectedgroup;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Donor details"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Donor name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: const InputDecoration(
                  labelText: "Phone number",
                  border: OutlineInputBorder(),
                ),
              ),
              DropdownButtonFormField(
                items: blood_group
                    .map((e) =>
                        DropdownMenuItem(child: Text(e), value: e,))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedgroup = val;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Choose blood group",
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  // _submitDonorDetails();
                  adddoners();
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}