import 'package:flutter/material.dart';

class KaizenFormPage extends StatefulWidget {
  const KaizenFormPage({Key? key}) : super(key: key);

  @override
  _KaizenFormPageState createState() => _KaizenFormPageState();
}

class _KaizenFormPageState extends State<KaizenFormPage> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajukan Kaizen'),
      ),

      body: Center(
        child: Image.asset('images/UnderConstruct.jpg'),
      ),

      // Form(
      //   child: Column(
      //     children: [
      //       TextFormField(
      //         controller: _nameController,
      //         decoration: InputDecoration(
      //             border: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(25),
      //             ),
      //             prefixText: "Nama",
      //             hintText: " Lengkap"),
      //       ),
      //       MaterialButton(
      //         onPressed: () {
      //           _printDate();
      //           _submit();
      //         },
      //         child: Text(
      //           "Submit",
      //           style: TextStyle(color: Colors.white),
      //         ),
      //         color: Theme.of(context).colorScheme.secondary,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  // void _printDate() {
  //   DateTime _time = DateTime.now();
  //   String _formattedTime = DateFormat('ddMMyy kk:mm').format(_time);
  //   print(_formattedTime);
  // }

  // Future _submit() async {
  //   DateTime _time = DateTime.now();
  //   String _formattedTime = DateFormat('ddMMyy').format(_time);

  //   final resp = await http.post(Uri.parse("${url}kaizen.php"), body: {
  //     'nama': _nameController.text,
  //     'id': '2210594',
  //     'waktu': _formattedTime,
  //   });

  //   var data = resp.body;
  //   print(data);
  // }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
