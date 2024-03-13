import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditingPage extends StatefulWidget {
  const EditingPage({super.key});

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final nameController=TextEditingController();
    final phoneController=TextEditingController();
    
    
  final blood_group = ["A+", "A-", 'B-', 'B+', 'O+', 'O-', 'AB-', "AB+"];
  String? selectedgroup;

 
  final CollectionReference donorsCollection =
      FirebaseFirestore.instance.collection('donor');
  
  void updatedonor(docId){
    final data={
    'name': nameController.text,
    'phone':phoneController.text,
    'bloodgroup':selectedgroup,
  };
  donorsCollection.doc(docId).update(data).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    final args=ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text =args["name"];
    phoneController.text =args["phone"];
    selectedgroup =args["bloodgroup"];
    final docId=args['id'];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("update page"),
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
                // value: selectedgroup!,
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
                  updatedonor(docId);
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: const Text(
                  "update",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]
          )
        )
      )
    );

  }
}