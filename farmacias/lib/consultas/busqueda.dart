import 'package:cloud_firestore/cloud_firestore.dart';

class Busqueda{
  
  Future<QuerySnapshot> buscarDatos(String tabla) async
  {
    CollectionReference collectionReference=FirebaseFirestore.instance.collection(tabla);
    QuerySnapshot C= await collectionReference.get();
    return C;
  }
}