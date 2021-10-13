
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:todo/model/model.dart';


class MyDatabase {

  Future<Database> userDatabase() async {
    Directory directory =await getApplicationSupportDirectory();
    return openDatabase(
      join(await getDatabasesPath(), 'NotesData.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT) ",
        );
      },
      version: 1,
    );
  }
  Future<void> insert(NoteItem noteItem)async{
    final Database db = await userDatabase();
    db.insert(noteItem.table(), noteItem.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    db.close();

  }

  Future<void> update(NoteItem noteItem) async{
    final Database db = await userDatabase();
    db.update(noteItem.table(), noteItem.toMap(),  where:"id = ?" , whereArgs:[noteItem.id]);
    db.close();


  }
  
  Future<int> delete(int id)async{
    final Database db = await userDatabase();
     return db.delete('notes', where:" id = ?" , whereArgs: [id] );

  }

  Future<List> getAll()  async {

    final Database db = await userDatabase();
    final List<Map<String, dynamic>> maps = await db.query('notes');
    var userList = [];
    for(var item in maps){
      userList.add(item);

    }
    return userList ;

  }


  Future<List> search(String text) async {
    List<Map<String, dynamic>> maps;
    final Database db = await userDatabase();
       maps  = await db.query(
           "notes",
           where: "name LIKE ?",
           whereArgs: ['%'+text +'%']
       );

    List userList = [];
    for(var item in maps){
      userList.add(item);
    }
    return userList ;
  }




}