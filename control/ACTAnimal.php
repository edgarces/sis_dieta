<?php
/**
*@package pXP
*@file gen-ACTAnimal.php
*@author  (admin)
*@date 18-09-2014 19:34:55
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTAnimal extends ACTbase{    
			
	function listarAnimal(){
		$this->objParam->defecto('ordenacion','id_animal');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODAnimal','listarAnimal');
		} else{
			$this->objFunc=$this->create('MODAnimal');
			
			$this->res=$this->objFunc->listarAnimal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarAnimal(){
		$this->objFunc=$this->create('MODAnimal');	
		if($this->objParam->insertar('id_animal')){
			$this->res=$this->objFunc->insertarAnimal($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarAnimal($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarAnimal(){
			$this->objFunc=$this->create('MODAnimal');	
		$this->res=$this->objFunc->eliminarAnimal($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>