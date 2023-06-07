import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_appfirebase/pages/scond_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController donarname = TextEditingController();
  TextEditingController donarphone = TextEditingController();
  List<String> bloodgroup = ['AB+', 'A+', 'A-', 'AB-', 'B+', 'B-', 'O+', 'O-'];
  String? selectedgroup;

  @override
  void dispose() {
    donarname.dispose(); // Dispose of the text editing controllers
    donarphone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Detiles'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'name', border: OutlineInputBorder()),
                  controller: donarname,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: donarphone,
                  decoration: const InputDecoration(
                      labelText: 'phone', border: OutlineInputBorder()),
                ),
              ),
              DropdownButtonFormField<String>(
                hint: const Text('Blood Group'),
                items: bloodgroup
                    .map((e) => DropdownMenuItem(child: Text(e), value: e))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedgroup = value;
                  });
                },
                value: selectedgroup,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: FloatingActionButton(
                  onPressed: () {
                    adddonar();
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.done),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void adddonar() {
    final data = {
      'name': donarname.text,
      'phone': donarphone.text,
      'group': selectedgroup ??
          'O+', // Use the selected group value or a default value
    };
    donar.add(data);
  }
}
