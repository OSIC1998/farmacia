import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmacias/pantallas/campos.dart';
import 'package:flutter/material.dart';

Widget Detalleproducto(BuildContext context, String ID, String nombre, String descripcion, double precio_actual, double precio_base, List carritoIDProducto, List carritoNombresproducto, List carritoCantidadProducto, List carritopPrecioProducto) {
  final cantidad=TextEditingController();
  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: Column(children: <Widget>[
        Text(nombre),
        SizedBox(
          height: 20,
        ),
        Text(descripcion),
        SizedBox(
          height: 20,
        ),
        Text("precio: \$ $precio_base"),
        Text("precio actual: \$ $precio_actual"),
        Text("Ahorras: \$ "+(precio_base-precio_actual).toStringAsFixed(2)),
        camposGeneral("cantidad", cantidad),
        botonAgregarCarrito(context, ID, cantidad, nombre, precio_actual, carritoIDProducto, carritoNombresproducto, carritoCantidadProducto, carritopPrecioProducto),
      ]),
    ),
  );
}
Widget Verpedidos(BuildContext context, String id, List pedidos) {
  return Container(
    child: Column(
      children: List.generate(pedidos.length, (index) {
        return Column(
          children: [
            Row(
              children: [
                Text("fecha(NULL) "),
                Container(
                  width: 80,
                  height: 30,
                  child: botonVerDetallePedidos(context, pedidos[index].toString()))
              ],
            )
          ],
        );
      }),
    ),

  );
}
Widget VerDetallespedidos(BuildContext context, List IDpedidosProducto, List pedidosCantidadProducto, List pedidosTotalProducto) {
  return Container(
    child: Column(
      children: List.generate(IDpedidosProducto.length, (index) {
        return Column(
          children: [
            Row(
              children: [
                Text(pedidosCantidadProducto[index].toString()),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 140,
                  child: Column(
                    children: [
                      Text("producto"),
                      Text("("+IDpedidosProducto[index].toString()+")", style: TextStyle(color: Colors.red),),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text("\$ "+pedidosTotalProducto[index].toStringAsFixed(2)),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      }),
    ),

  );
}


Widget carrito(BuildContext context, List carritoIDProducto, List carritoNombresproducto, List carritoCantidadProducto, List carritopPrecioProducto)
{
  double total=0.0;
  return Container(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: List.generate(carritoIDProducto.length, (index) {
              total+=carritoCantidadProducto[index]*carritopPrecioProducto[index];
              return Column(children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(carritoCantidadProducto[index].toString()),
                      SizedBox(width: 10,),
                      Container(width: 150, child: Text(carritoNombresproducto[index].toString())),
                      Text("\$ ${carritopPrecioProducto[index]*carritoCantidadProducto[index]}"),
                      botoneliminarpedido(context, index, carritoIDProducto, carritoNombresproducto, carritoCantidadProducto, carritopPrecioProducto),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
              ],);
            },),
          ),
          SizedBox(height: 10,),
          Text("TOTAL: \$ "+total.toStringAsFixed(2)),
        ],
      ),
    ),
  );
}

Widget botoneliminarpedido(BuildContext context, int index,List carritoIDProducto, List carritoNombresproducto, List carritoCantidadProducto, List carritopPrecioProducto)
{
  return Container(
    child: MaterialButton(
      color: Color.fromARGB(255, 254, 0, 0),
      elevation: 0.0,
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)
        ),
        onPressed: (){
          carritoCantidadProducto.removeAt(index);
          carritoIDProducto.removeAt(index);
          carritoNombresproducto.removeAt(index);
          carritopPrecioProducto.removeAt(index);
          Navigator.of(context).pop();
        },
        child: Icon(
              Icons.delete_rounded,
              color: Colors.white,
              size: 30.0,
            ),
    ),
  );
}