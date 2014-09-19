<?php
/**
*@package pXP
*@file gen-MODGranjaUsuario.php
*@author  (admin)
*@date 17-09-2014 19:02:44
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODGranjaUsuario extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarGranjaUsuario(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dieta.ft_granja_usuario_sel';
		$this->transaccion='DA_GRUS_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_granja_usuario','int4');
		$this->captura('id_granja','int4');
		$this->captura('id_usuario','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_reg','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('desc_persona','text');
		$this->captura('cuenta','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarGranjaUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_granja_usuario_ime';
		$this->transaccion='DA_GRUS_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_granja','id_granja','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarGranjaUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_granja_usuario_ime';
		$this->transaccion='DA_GRUS_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_granja_usuario','id_granja_usuario','int4');
		$this->setParametro('id_granja','id_granja','int4');
		$this->setParametro('id_usuario','id_usuario','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarGranjaUsuario(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_granja_usuario_ime';
		$this->transaccion='DA_GRUS_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_granja_usuario','id_granja_usuario','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>