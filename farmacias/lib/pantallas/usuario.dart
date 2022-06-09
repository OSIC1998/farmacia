import 'package:farmacias/pantallas/campos.dart';
import 'package:farmacias/pantallas/inicio.dart';
import 'package:flutter/material.dart';

Widget login(BuildContext context, TextEditingController IDUser, TextEditingController correo, TextEditingController nombre, TextEditingController pass, TextEditingController passR, TextEditingController direccion) {
  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          camposGeneral("usuario", correo),
          camposPass("contraseña", pass),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            child: Text("Crear cuenta",style: TextStyle(color: Colors.blue),),
            onTap: () {
              showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                title: Text("Crear cuenta"),
                content: agregarUsuario(context, correo, nombre, pass, passR, direccion),
                actions: <Widget>[
                  FlatButton(onPressed: (){Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => inicio(),),(route) => false,);}, child: Text("CERRAR"))
                ],
              ));
            },
          ),
          SizedBox(
            width: 10,
          ),
          botonIniciaSesion(context, IDUser, correo, nombre, pass, passR, direccion),
        ],
      ),
    ),
  );
}

Widget mostrarPerfil(BuildContext context, TextEditingController IDUser, TextEditingController correo, TextEditingController nombre, TextEditingController pass, TextEditingController passR, TextEditingController direccion) {
  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Text(nombre.text, style: TextStyle(fontSize: 25),),
          SizedBox(
            height: 10,
          ),
          Text(correo.text),
          SizedBox(
            height: 10,
          ),
          Text("Mi dirección:"),
          Text(direccion.text),
          SizedBox(
            height: 10,
          ),
          botonVerPedidos(context, IDUser),
          SizedBox(
            height: 10,
          ),
          botonCerrarSecion(context, IDUser, correo, nombre, pass, passR, direccion),
        ],
      ),
    ),
  );
}

Widget agregarUsuario(BuildContext context, TextEditingController correo, TextEditingController nombre, TextEditingController pass, TextEditingController passR, TextEditingController direccion) {
  correo.text="";
  pass.text="";
  passR.text="";
  direccion.text="";
  nombre.text="";

  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          camposGeneral("correo", correo),
          camposGeneral("nombre", nombre),
          camposPass("contraseña", pass),
          camposPass("contraseña", passR),
          camposGeneral("direccion", direccion),
          SizedBox(
            width: 10,
          ),
          botonAgregarUser(context, correo, nombre, pass, passR, direccion)
        ],
      ),
    ),
  );
}
