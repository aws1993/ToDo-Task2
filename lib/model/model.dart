class NoteItem{
   int? id ;
  String? content ;




  NoteItem(dynamic obj){
    id = obj['id'];
    content = obj['content'];


  }
  NoteItem.fromMap(Map<String ,dynamic> map){
    this.id = map['id'];
    this.content = map['content'];
  }

  @override
  String table() {
    return 'notes' ;
  }

  @override
  Map<String,dynamic > toMap() {
    return {
      'id': this.id,
      'content': this.content ,

    };
  }

}