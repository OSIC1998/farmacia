import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmacias/consultas/BDFarmacias.dart';
import 'package:farmacias/consultas/busqueda.dart';
import 'package:farmacias/pantallas/campos.dart';
import 'package:farmacias/pantallas/carritoYproductos.dart';
import 'package:farmacias/pantallas/usuario.dart';
import 'package:flutter/material.dart';

class inicio extends StatefulWidget {
  const inicio({Key? key}) : super(key: key);

  @override
  State<inicio> createState() => _inicioState();
}

class _inicioState extends State<inicio> {
  BDFarmacia BD= new BDFarmacia();
  Busqueda B=new Busqueda();
  final menuItem=["home","medicos","Farmacias"];
  final IDUser=TextEditingController();
  final correo=TextEditingController();
  final pass=TextEditingController();
  final nombre=TextEditingController();
  final passR=TextEditingController();
  final direccion=TextEditingController();
  late List idcategorias=[];
  late List nombrescategoria=[];
  late List idSeleccion=[];
  late List idSeleccioncategoria=[];
  late List nombresSeleccion=[];
  late List horaSeleccion=[];
  late List descripcionSeleccion=[];
  late List TelSeleccion=[];
  late List presioBaseSeleccion=[];
  late List presioActualSeleccion=[];
  ///////////////carrito////////////////////
  late List carritoIDProducto=[];
  late List carritoNombresproducto=[];
  late List carritoCantidadProducto=[];
  late List carritopPrecioProducto=[];
  ///////////////////////////////////
  
  int activoMenu1=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 210, 203),
        title: menu(),
      ),
      backgroundColor: Colors.white,
      body: menuPantallas(),
    );
  }

  Widget menu(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                  title: Text("Productos seleccionados"),
                  content: carrito(context, carritoIDProducto, carritoNombresproducto, carritoCantidadProducto, carritopPrecioProducto),
                  actions: <Widget>[
                    FlatButton(onPressed: () async {
                      if(IDUser.text=="")
                      {
                        Navigator.of(context).pop();
                        showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                          content: Text("Debe iniciar sesión para poder compra"),
                          actions: <Widget>[
                            FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
                          ],
                        ));
                      }
                      else{
                        int R= await i.agregarPedidoCarrito(IDUser.text, carritoIDProducto, carritoCantidadProducto, carritopPrecioProducto);
                        if(R==1)
                        {
                          carritoCantidadProducto=[];
                          carritoIDProducto=[];
                          carritopPrecioProducto=[];
                          carritoNombresproducto=[];
                          Navigator.of(context).pop();
                          showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                            content: Text("Compra realizada con éxito"),
                            actions: <Widget>[
                              FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("OK"))
                            ],
                          ));
                        }
                        else{
                          Navigator.of(context).pop();
                        }
                      }
                    }, child: Text("pagar")),
                    FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("CERRAR"))
                  ],
                ));
            },
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
              size: 30.0,
            ),
          ),

          GestureDetector(
            onTap: () {
              if(IDUser.text!="")
              {
                showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                  title: Text("Usuario"),
                  content: mostrarPerfil(context, IDUser, correo, nombre, pass, passR, direccion),
                  actions: <Widget>[
                    FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("CERRAR"))
                  ],
                ));
              }
              else{
                showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                  title: Text("Inicia sesión"),
                  content: login(context, IDUser, correo, nombre, pass, passR, direccion),
                  actions: <Widget>[
                    FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("CERRAR"))
                  ],
                ));
              }
            },
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ]
        ),
    );
  }

  Widget menuPantallas(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: List.generate(menuItem.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 25),
                child: GestureDetector(
                  onTap: () async {
                    activoMenu1=index;
                    if(activoMenu1==2){
                      horaSeleccion=[];
                      TelSeleccion=[];
                      idSeleccion=[];
                      nombresSeleccion=[];
                      descripcionSeleccion=[];
                      QuerySnapshot medicamentoBD = await B.buscarDatos(BD.tabla_farmacia);
                      if(medicamentoBD.docs.length != 0){
                        for(var doc in medicamentoBD.docs){
                          idSeleccion.add(doc.id);
                          nombresSeleccion.add(doc.get(BD.campo_tabla_farmacia_nombre));
                          descripcionSeleccion.add(doc.get(BD.campo_tabla_farmacia_direccion));
                          horaSeleccion.add(doc.get(BD.campo_tabla_farmacia_horario));
                          TelSeleccion.add(doc.get(BD.campo_tabla_farmacia_telefono));
                        }
                      }
                    }
                    else if(activoMenu1==1)
                    {
                      idcategorias=[];
                      nombrescategoria=[];
                      QuerySnapshot categoriasMedicamentoBD = await B.buscarDatos(BD.tabla_categorias);
                      if(categoriasMedicamentoBD.docs.length != 0){
                        for(var doc in categoriasMedicamentoBD.docs){
                          idcategorias.add(doc.id);
                          nombrescategoria.add(doc.get(BD.campo_tabla_categorias_nombre));
                        }
                      }
                      idSeleccioncategoria=[];
                      idSeleccion=[];
                      nombresSeleccion=[];
                      descripcionSeleccion=[];
                      presioBaseSeleccion=[];
                      presioActualSeleccion=[];
                      QuerySnapshot medicamentoBD = await B.buscarDatos(BD.tabla_medicamentos);
                      if(medicamentoBD.docs.length != 0){
                        for(var doc in medicamentoBD.docs){
                          idSeleccion.add(doc.id);
                          idSeleccioncategoria.add(doc.get(BD.campo_tabla_medicamentos_id_categoria));
                          nombresSeleccion.add(doc.get(BD.campo_tabla_medicamentos_nombre));
                          descripcionSeleccion.add(doc.get(BD.campo_tabla_medicamentos_descripcion));
                          presioBaseSeleccion.add(doc.get(BD.campo_tabla_medicamentos_precio_base));
                          presioActualSeleccion.add(doc.get(BD.campo_tabla_medicamentos_precio_actual));
                        }
                      }
                    }
                    else{
                      horaSeleccion=[];
                      TelSeleccion=[];
                      idcategorias=[];
                      nombrescategoria=[];
                      idSeleccioncategoria=[];
                      idSeleccion=[];
                      nombresSeleccion=[];
                      descripcionSeleccion=[];
                      presioBaseSeleccion=[];
                      presioActualSeleccion=[];
                    }
                    setState(() {
                      activoMenu1 = index;
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menuItem[index],
                          style: TextStyle(
                          fontSize: 15,
                          color: activoMenu1 == index
                            ? Colors.blue
                            : Colors.grey,
                          fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      activoMenu1 == index
                        ? Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                        )
                      : Container()
                    ],
                  ),
                ),
              );
            },),
          ),
          getPaginas(),
        ],
      ),
    );
  }
  Widget getPaginas() {
    return IndexedStack(
      index: activoMenu1,
      children: [
        categorias(),
        categorias(),
        categorias(),
      ],
    );
  }
  Widget categorias(){
    return activoMenu1 == 1
    ?Column(
      children: List.generate(idcategorias.length, (index) {
        return Column(
          children: <Widget>[
            Text(nombrescategoria[index],style: TextStyle(fontSize: 30),),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  children: List.generate(idSeleccion.length, (index2) {
                    return Container(
                      child: idSeleccioncategoria[index2] == idcategorias[index]
                        ?Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(context: context, barrierDismissible: false, builder: (context)=>AlertDialog(
                              title: Text("Detalle producton"),
                              content: Detalleproducto(context, idSeleccion[index2], nombresSeleccion[index2], descripcionSeleccion[index2], presioActualSeleccion[index2], presioBaseSeleccion[index2], carritoIDProducto, carritoNombresproducto, carritoCantidadProducto, carritopPrecioProducto),
                              actions: <Widget>[
                                FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("CERRAR"))
                              ],
                            ));
                            
                          },
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 150,
                                color: Color.fromARGB(224, 164, 224, 162),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(nombresSeleccion[index2],style: TextStyle(fontSize: 15),),
                                      Text("\$ "+presioActualSeleccion[index2].toString()),
                                    ],
                                  ),
                              ))
                            ],
                          ),
                        ),
                      ):Container(width: 0,),
                    );
                  },),
                ),
              ),
            ),
          ],
        );
      },),
    ):Container(
      child: activoMenu1 == 2
      ?Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(nombresSeleccion.length, (index) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Text(nombresSeleccion[index].toString(), style: TextStyle(fontSize: 20),),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Dirección: "+descripcionSeleccion[index].toString()),
                        Text("Teléfono: "+TelSeleccion[index].toString()),
                        Text("Horas: "+horaSeleccion[index].toString()),
                      ],
                    ),
                  ),
                  botonIrFarmasia(context, descripcionSeleccion[index].toString())
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 500,
                height: 3,
                decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(5)),
            )
            ],
          ),
        );
      }),
    ):Container(
      height: 400,
      child: Center(
        child: Image(
          image: AssetImage('images/logo.jpeg'),
          height: 140,
        ),
      ),
      ),
    );
  }
}