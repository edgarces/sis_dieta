<?php
/**
*@package pXP
*@file gen-MODIngredienteNutriente.php
*@author  (admin)
*@date 17-09-2014 21:31:27
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODIngredienteNutriente extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarIngredienteNutriente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dieta.ft_ingrediente_nutriente_sel';
		$this->transaccion='DA_INNU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_ingrediente_nutriente','int4');
		$this->captura('id_ingrediente','int4');
		$this->captura('id_nutriente','int4');
		$this->captura('porcentaje_nutriente','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre','varchar');
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarIngredienteNutriente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_ingrediente_nutriente_ime';
		$this->transaccion='DA_INNU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ingrediente','id_ingrediente','int4');
		$this->setParametro('id_nutriente','id_nutriente','int4');
		$this->setParametro('porcentaje_nutriente','porcentaje_nutriente','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarIngredienteNutriente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_ingrediente_nutriente_ime';
		$this->transaccion='DA_INNU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ingrediente_nutriente','id_ingrediente_nutriente','int4');
		$this->setParametro('id_ingrediente','id_ingrediente','int4');
		$this->setParametro('id_nutriente','id_nutriente','int4');
		$this->setParametro('porcentaje_nutriente','porcentaje_nutriente','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarIngredienteNutriente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_ingrediente_nutriente_ime';
		$this->transaccion='DA_INNU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_ingrediente_nutriente','id_ingrediente_nutriente','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>