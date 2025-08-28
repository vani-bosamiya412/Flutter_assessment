import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(home: PetMoodTrackerCard(), debugShowCheckedModeBanner: false,));
}

class PetMoodTrackerCard extends StatefulWidget {
  const PetMoodTrackerCard({super.key});

  @override
  State<PetMoodTrackerCard> createState() => _PetMoodTrackerCardState();
}

class _PetMoodTrackerCardState extends State<PetMoodTrackerCard> {

  TextEditingController petNameController = TextEditingController();
  String? petName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Mood Tracker"),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            TextFormField(
              controller: petNameController,
              decoration: InputDecoration(
                labelText: "Enter Pet Name",
                border: OutlineInputBorder()
              ),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return "Please enter pet name";
                }
                return null;
              },
            ),
            SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  petName = petNameController.text;
                });
              },
              child: Text("Show Mood Card", style: TextStyle(fontSize: 16),)
            ),
            SizedBox(height: 20,),
            if(petName != null && petName!.isNotEmpty)
              PetMoodCard(petName: petName!),
          ],
        ),
      ),
    );
  }
}

class PetMoodCard extends StatefulWidget {
  const PetMoodCard({super.key, required this.petName});

  final String petName;

  @override
  State<PetMoodCard> createState() => _PetMoodCardState();
}

class _PetMoodCardState extends State<PetMoodCard> {
  String? selectedMood;

  Map<String, Map<String, dynamic>> moodDetails = {
    "Happy": {"emoji": "😊", "color": Colors.green},
    "Sad": {"emoji": "😢", "color": Colors.blue},
    "Energetic": {"emoji": "⚡", "color": Colors.red},
    "Sleepy": {"emoji": "😴", "color": Colors.grey},
  };

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat("MMM dd, yyyy").format(DateTime.now());

    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.petName, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Text(currentDate, style: TextStyle(color: Colors.black54),),
            SizedBox(height: 16),
            DropdownButton(
              value: selectedMood,
              hint: Text("Select Mood"),
              isExpanded: true,
              items: moodDetails.keys.map((String mood) {
                return DropdownMenuItem(
                  value: mood,
                  child: Text(mood)
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMood = value;
                });
              }
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: selectedMood == null ? Colors.grey.shade300 : moodDetails[selectedMood]!["color"],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(selectedMood == null ? "No mood selected" : "${moodDetails[selectedMood]!["emoji"]} $selectedMood", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
            )
          ],
        ),
      ),
    );
  }
}

