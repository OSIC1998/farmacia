import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmacias/consultas/BDFarmacias.dart';
import 'package:flutter/material.dart';

class insertar{
  late BDFarmacia bd=new BDFarmacia();
  Future<int> agregarUser(TextEditingController nombre,TextEditingController pass,TextEditingController correo, TextEditingController direccion)async{
    int respuesta=0;
    try {
      await FirebaseFirestore.instance.collection(bd.tabla_usuario).doc().set({
        bd.campo_tabla_usuario_correo: correo.text,
        bd.campo_tabla_usuario_clave: pass.text,
        bd.campo_tabla_usuario_nombre: nombre.text,
        bd.campo_tabla_usuario_direccion: direccion.text
      });
      respuesta=1;
    } catch (e) {
      respuesta=0;
      print(e);
    }
    return respuesta;
  }
  Future<int> agregarPedidoCarrito(String IDUser, List carritoIDProducto, List carritoCantidadProducto, List carritopPrecioProducto) async {
    int respuesta=0;
    try {
      await FirebaseFirestore.instance.collection(bd.tabla_pedido).add({
        bd.campo_tabla_pedido_iduser: IDUser,
      }).then((documentReference) async {
        for(int i=0; i <= carritoIDProducto.length; i++)
        {
          await FirebaseFirestore.instance.collection(bd.tabla_detalle_pedido).doc().set({
            bd.campo_tabla_detalle_pedido_cantidad: carritoCantidadProducto[i].toString(),
            bd.campo_tabla_detalle_pedido_id_pedido: documentReference.id.toString(),
            bd.campo_tabla_detalle_pedido_id_producto: carritoIDProducto[i].toString(),
            bd.campo_tabla_detalle_pedido_total_pagar: carritopPrecioProducto[i],
          });
        }
          print(documentReference.id);   
        }).catchError((e) {  
            print(e);  
        });
      respuesta=1;
    } catch (e) {
      respuesta=0;
      print(e);
    }
    return respuesta;
  }

  int agregar() {
    int respuesta=0;
    try {
      FirebaseFirestore.instance.collection(bd.tabla_farmacia).add({
        bd.campo_tabla_farmacia_direccion: "#5-B, Av. Juan Vicente Villacorta, Zacatecoluca",
        bd.campo_tabla_farmacia_horario: "6:00AM-8:00PM",
        bd.campo_tabla_farmacia_nombre: "Farmacia Los Robles Zacatecoluca",
        bd.campo_tabla_farmacia_telefono: "2334 2488",
      }).then((documentReference) {  
            print(documentReference.id);   
        }).catchError((e) {  
            print(e);  
        });
      respuesta=1;
    } catch (e) {
      respuesta=0;
      print(e);
    }
    return respuesta;
  }
}