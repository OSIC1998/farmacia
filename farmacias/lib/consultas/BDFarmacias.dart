import 'package:cloud_firestore/cloud_firestore.dart';

class BDFarmacia{
  ///////////////////             tablas
  get tabla_usuario => "usuario";
  get tabla_farmacia => "farmacias";
  get tabla_medicamentos=> "medicamentos";
  get tabla_categorias=> "categoria";
  get tabla_pedido=>"pedidos";
  get tabla_detalle_pedido=>"Detalle_pedido";
  //////////////////usuaruo
  get campo_tabla_usuario_correo => "correo";
  get campo_tabla_usuario_clave => "clave";
  get campo_tabla_usuario_nombre => "nombre";
  get campo_tabla_usuario_direccion => "direccion_user";
  //////////////////////////////////////////////////////////
  ///
  /////////////////Farmacia
  get campo_tabla_farmacia_nombre => "nombre";
  get campo_tabla_farmacia_direccion => "direccion";
  get campo_tabla_farmacia_telefono => "telefono";
  get campo_tabla_farmacia_horario => "horario";
  //////////////////////////////////////////////////////////////
  ///
  ///////////////////////////categoria
  get campo_tabla_categorias_nombre => "nombre";
  //////////////////////////////////////////////////////////////
  ///
  ///////////////////////////////medicamentos
  get campo_tabla_medicamentos_nombre => "nombre";
  get campo_tabla_medicamentos_descripcion => "descripcion";
  get campo_tabla_medicamentos_id_categoria => "id_categoria";
  get campo_tabla_medicamentos_precio_actual => "precio_actual";
  get campo_tabla_medicamentos_precio_base => "precio_base";
  ////////////////////////////////////////////////////////////////////////
  ///
  ///////////////////////////pedido
  get campo_tabla_pedido_iduser=>"ID_user";
  //////////////////////////////////////////////////////////////////////////
  ///
  /////////////////////////detallle producto
  get campo_tabla_detalle_pedido_id_pedido=>"id_pedido";
  get campo_tabla_detalle_pedido_id_producto=>"id_producto";
  get campo_tabla_detalle_pedido_cantidad=>"cantidad";
  get campo_tabla_detalle_pedido_total_pagar=>"total_pagar";
  ////////////////////////////////////////////////////////////////////////////
}