import 'package:flutter/material.dart';
import 'package:todo/database/database.dart';
import 'package:todo/model/model.dart';
class NewNotePage extends StatefulWidget {



  @override
  _NewNotePageState createState() => _NewNotePageState();
}

class _NewNotePageState extends State<NewNotePage> {
  MyDatabase myDatabase =MyDatabase();
  TextEditingController _editingController =TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()=>_save() ,
      child: Scaffold(

        appBar: AppBar(
          title: Text('New Note'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: true,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _editingController,


          ),
        ),
      ),
    );
  }
  Future<bool>_save() async {
      if(_editingController.text !=''){
        var inserNote= NoteItem({
          'content':_editingController.text,
        });
        await myDatabase.insert(inserNote);
        Navigator.of(context).pop();

      }
      return true;




  }
}
