import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmacias/consultas/BDFarmacias.dart';
import 'package:farmacias/consultas/busqueda.dart';
import 'package:farmacias/consultas/insercion.dart';
import 'package:farmacias/pantallas/carritoYproductos.dart';
import 'package:farmacias/pantallas/inicio.dart';
import 'package:flutter/material.dart';

insertar i=new insertar();
Busqueda B=new Busqueda();
BDFarmacia BD=new BDFarmacia();

Widget camposGeneral(String Ncampo, TextEditingController textEditingController) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          labelText: Ncampo,
          hintText: Ncampo, fillColor: Colors.white, filled: true),   
      ));
}
Widget camposPass(String Ncampo, TextEditingController textEditingController) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      controller: textEditingController,
      obscureText: true,
      decoration: InputDecoration(
        labelText: Ncampo,
        hintText: Ncampo, fillColor: Colors.white, filled: true),
    )
  );
}

Widget botonIrFarmasia(BuildContext context, String D,) {
  return Container(
    child: MaterialButton(
      color: Color.fromARGB(255, 4, 254, 0),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: () {
        },
        child: Text(
          "Ir",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    )
  );
}


Widget botonVerDetallePedidos(BuildContext context, String ID,) {
  return Container(
    child: MaterialButton(
      color: Color.fromARGB(255, 4, 254, 0),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: () async {
          List IDpedidosProducto=[];
          List pedidosCantidadProducto=[];
          List pedidosTotalProducto=[];
          QuerySnapshot C= await B.buscarDatos(BD.tabla_detalle_pedido);
          if(C.docs.length!=0)
          {
            for(var doc in C.docs)
            {
              if(doc.get(BD.campo_tabla_detalle_pedido_id_pedido)==ID)
              {
                IDpedidosProducto.add(doc.get(BD.campo_tabla_detalle_pedido_id_producto));
                pedidosCantidadProducto.add(doc.get(BD.campo_tabla_detalle_pedido_cantidad));
                pedidosTotalProducto.add(doc.get(BD.campo_tabla_detalle_pedido_total_pagar));
              }
            }
          }
          showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
            title: Text("pedidos"),
            content: VerDetallespedidos(context, IDpedidosProducto, pedidosCantidadProducto, pedidosTotalProducto),
            actions: <Widget>[
              FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
            ],
          ),);
        },
        child: Text(
          "Ver",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    )
  );
}

Widget botonVerPedidos(BuildContext context, TextEditingController IDUser,) {
  return Container(
    child: MaterialButton(
      color: Color.fromARGB(255, 4, 254, 0),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:10, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: ()async{
          List pedidos=[];
          QuerySnapshot C= await B.buscarDatos(BD.tabla_pedido);
          if(C.docs.length!=0)
          {
            for(var doc in C.docs)
            {
              if(doc.get(BD.campo_tabla_pedido_iduser)==IDUser.text)
              {
                pedidos.add(doc.id);
              }
            }
          }
          showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
            title: Text("pedidos"),
            content: Verpedidos(context, IDUser.text, pedidos),
            actions: <Widget>[
              FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
            ],
          ),);
        },
        child: Text(
          "Ver pedidos",
          style: TextStyle(color: Colors.white, fontSize: 10),
        )
    )
  );
}
Widget botonAgregarCarrito(BuildContext context, String ID, TextEditingController cantidad, String nombre, double precio_actual, List carritoIDProducto, List carritoNombresproducto, List carritoCantidadProducto, List carritopPrecioProducto) {
  return Container(
    child: MaterialButton(
      color: const Color(0x00ff0069fe),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: (){
          try{
            if(cantidad.text==""){
              showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                content: Text("Llenar campos vacíos"),
                actions: <Widget>[
                  FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
                ],
              ));
            }
            else{
              int C=int.parse(cantidad.text);
              carritoIDProducto.add(ID);
              carritoNombresproducto.add(nombre);
              carritoCantidadProducto.add(C);
              carritopPrecioProducto.add(precio_actual);
              showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                content: Text("Se agregaron $C $nombre, a su carrito"),
                actions: <Widget>[
                  FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
                ],
              ));

            }
          }
          catch (e){
            showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
              content: Text(e.toString()),
              actions: <Widget>[
                FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
              ],
            ));
          }
        },
        child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
    ),
  );
}
Widget botonIniciaSesion(BuildContext context, TextEditingController IDUser,TextEditingController correo, TextEditingController nombre, TextEditingController pass, TextEditingController passR, TextEditingController direccion) {
  return Container(
    child: MaterialButton(
      color: const Color(0x00ff0069fe),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: ()async{
          if(correo.text==""||pass.text=="")
          {
            showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
              content: Text("Llenar campos vacíos"),
              actions: <Widget>[
                FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
              ],
            ));
          }
          else{
            QuerySnapshot loguin = await B.buscarDatos(BD.tabla_usuario);
            int validador=0;
            if(loguin.docs.length != 0){
              for(var doc in loguin.docs){
                if(doc.get(BD.campo_tabla_usuario_correo)==correo.text && doc.get(BD.campo_tabla_usuario_clave)==pass.text)
                {
                  validador=1;
                  IDUser.text=doc.id;
                  correo.text=doc.get(BD.campo_tabla_usuario_correo);
                  nombre.text=doc.get(BD.campo_tabla_usuario_nombre);
                  pass.text=doc.get(BD.campo_tabla_usuario_clave);
                  direccion.text=doc.get(BD.campo_tabla_usuario_direccion);
                }
              }
            }
            if(validador==1){
              Navigator.of(context).pop();
            }
            else{
              showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                content: Text("Correo o contraseña incorrecto"),
                actions: <Widget>[
                  FlatButton(onPressed: (){
                    pass.text="";
                    Navigator.of(context).pop();
                  }, child: Text("OK")),
                ],
              ));
            }
          }
        },
        child: Text(
          "Inicia sesión",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    )
  );
}

Widget botonCerrarSecion(BuildContext context, TextEditingController IDUser,TextEditingController correo, TextEditingController nombre, TextEditingController pass, TextEditingController passR, TextEditingController direccion) {
  return Container(
    child: MaterialButton(
      color: Color.fromARGB(255, 163, 16, 0),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: (){
          IDUser.text="";
          correo.text="";
          nombre.text="";
          pass.text="";
          pass.text="";
          direccion.text="";
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => inicio(),),(route) => false,);
        },
        child: Text(
          "Cerrar sesion",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    )
  );
}

Widget botonAgregartemporal(BuildContext context,) {
  return Container(
    child: MaterialButton(
      color: const Color(0x00ff0069fe),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: ()async{
        int respuesta=await i.agregar();
        print(respuesta);
        },
        child: Text(
          "crear documento en vase",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    )
  );
}

Widget botonAgregarUser(BuildContext context,TextEditingController correo, TextEditingController nombre, TextEditingController pass, TextEditingController passR, TextEditingController direccion) {
  return Container(
    child: MaterialButton(
      color: const Color(0x00ff0069fe),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: ()async{
          if(correo.text!=""&&
          nombre.text!=""&&
          pass.text!=""&&
          passR.text!=""&&
          direccion.text!=""){
            if(pass.text==passR.text)
            {
              int respuesta=await i.agregarUser(nombre, pass, correo, direccion);
              if(respuesta==1)
              {
                showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                  content: Text("Usuario agregado correctamente"),
                  actions: <Widget>[
                    FlatButton(onPressed: (){
                      pass.text="";
                      passR.text="";
                      correo.text="";
                      nombre.text="";
                      direccion.text="";
                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => inicio(),),(route) => false,);
                    }, child: Text("OK"))
                  ],
                ));
              }
              else
              {
                showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                  content: Text("Usuario no se pudo agregar"),
                  actions: <Widget>[
                    FlatButton(onPressed: (){Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => inicio(),),(route) => false,);}, child: Text("OK"))
                  ],
                ));
              }
              pass.text="";
              passR.text="";
            }
            else{
              pass.text="";
              passR.text="";
              showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                content: Text("Las contraseñas no coinciden"),
                actions: <Widget>[
                  FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
                ],
              ));
            }
          }
          else{
            showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
              content: Text("Llenar campos vacíos"),
              actions: <Widget>[
                FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
              ],
            ));
          }
        },
        child: Text(
          "crear usuario",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )
    )
  );
}

