<?php
/**
*@package pXP
*@file gen-MODAnimal.php
*@author  (admin)
*@date 18-09-2014 19:34:55
*@description Clase que envia los parametros requeridos a la Base de datos para la ejecucion de las funciones, y que recibe la respuesta del resultado de la ejecucion de las mismas
*/

class MODAnimal extends MODbase{
	
	function __construct(CTParametro $pParam){
		parent::__construct($pParam);
	}
			
	function listarAnimal(){
		//Definicion de variables para ejecucion del procedimientp
		$this->procedimiento='dieta.ft_animal_sel';
		$this->transaccion='DA_ANI_SEL';
		$this->tipo_procedimiento='SEL';//tipo de transaccion
				
		//Definicion de la lista del resultado del query
		$this->captura('id_animal','int4');
		$this->captura('estado_reg','varchar');
		$this->captura('tip_raza','varchar');
		$this->captura('descripcion','varchar');
		$this->captura('edad','int4');
		$this->captura('raza','varchar');
		$this->captura('id_usuario_reg','int4');
		$this->captura('usuario_ai','varchar');
		$this->captura('fecha_reg','timestamp');
		$this->captura('id_usuario_ai','int4');
		$this->captura('id_usuario_mod','int4');
		$this->captura('fecha_mod','timestamp');
		$this->captura('usr_reg','varchar');
		$this->captura('usr_mod','varchar');
		
		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();
		
		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function insertarAnimal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_animal_ime';
		$this->transaccion='DA_ANI_INS';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tip_raza','tip_raza','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('edad','edad','int4');
		$this->setParametro('raza','raza','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function modificarAnimal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_animal_ime';
		$this->transaccion='DA_ANI_MOD';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_animal','id_animal','int4');
		$this->setParametro('estado_reg','estado_reg','varchar');
		$this->setParametro('tip_raza','tip_raza','varchar');
		$this->setParametro('descripcion','descripcion','varchar');
		$this->setParametro('edad','edad','int4');
		$this->setParametro('raza','raza','varchar');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
	function eliminarAnimal(){
		//Definicion de variables para ejecucion del procedimiento
		$this->procedimiento='dieta.ft_animal_ime';
		$this->transaccion='DA_ANI_ELI';
		$this->tipo_procedimiento='IME';
				
		//Define los parametros para la funcion
		$this->setParametro('id_animal','id_animal','int4');

		//Ejecuta la instruccion
		$this->armarConsulta();
		$this->ejecutarConsulta();

		//Devuelve la respuesta
		return $this->respuesta;
	}
			
}
?>