<?php
/**
*@package pXP
*@file gen-MODDieta.php
*@author  (admin)
*@date 18-09-2014 19:35:16
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODDieta extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarDieta(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dieta.ft_dieta_sel';
		$this->transaccion='DA_DIE_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_dieta','int4');
		$this->captura('id_animal','int4');
		$this->captura('descripcion','varchar');
		$this->captura('tipo_dieta','varchar');
		$this->captura('estado_reg','varchar');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_reg','int4');
		$this->captura('fecha_reg','timestamp');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_mod','timestamp');
		$this->captura('id_usuario_mod','int4');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		$this->captura('raza','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarDieta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_dieta_ime';
		$this->transaccion='DA_DIE_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_animal','id_animal','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo_dieta','tipo_dieta','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarDieta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_dieta_ime';
		$this->transaccion='DA_DIE_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dieta','id_dieta','int4');
		$this->setParametro('id_animal','id_animal','int4');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('tipo_dieta','tipo_dieta','varchar');
		$this->setParametro('estado_reg','estado_reg','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarDieta(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_dieta_ime';
		$this->transaccion='DA_DIE_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_dieta','id_dieta','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>