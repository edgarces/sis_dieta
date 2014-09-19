<?php
/**
*@package pXP
*@file gen-MODDietaNutriente.php
*@author  (admin)
*@date 18-09-2014 21:17:39
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDietaNutriente extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDietaNutriente(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dieta.ft_dieta_nutriente_sel';
		$this->transaccion='DA_DINU_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_dieta_nutriente','int4');
		$this->captura('id_nutriente','int4');
		$this->captura('id_dieta','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('nombre','varchar');		
		$this->captura('dieta_max','numeric');
		$this->captura('dieta_min','numeric');
		$this->captura('porcentaje','int4');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDietaNutriente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_dieta_nutriente_ime';
		$this->transaccion='DA_DINU_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_nutriente','id_nutriente','int4');
		$this->setParametro('id_dieta','id_dieta','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('dieta_min','dieta_min','numeric');
		$this->setParametro('dieta_max','dieta_max','numeric');
		$this->setParametro('porcentaje','porcentaje','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDietaNutriente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_dieta_nutriente_ime';
		$this->transaccion='DA_DINU_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dieta_nutriente','id_dieta_nutriente','int4');
		$this->setParametro('id_nutriente','id_nutriente','int4');
		$this->setParametro('id_dieta','id_dieta','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('dieta_min','dieta_min','numeric');
		$this->setParametro('dieta_max','dieta_max','numeric');
		$this->setParametro('porcentaje','porcentaje','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDietaNutriente(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_dieta_nutriente_ime';
		$this->transaccion='DA_DINU_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dieta_nutriente','id_dieta_nutriente','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>