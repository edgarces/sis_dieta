<?php
/**
*@package pXP
*@file gen-ACTIngrediente.php
*@author  (admin)
*@date 17-09-2014 21:31:18
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTIngrediente extends ACTbase{    
			
	function listarIngrediente(){
		$this->objParam->defecto('ordenacion','id_ingrediente');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODIngrediente','listarIngrediente');
		} else{
			$this->objFunc=$this->create('MODIngrediente');
			
			$this->res=$this->objFunc->listarIngrediente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarIngrediente(){
		$this->objFunc=$this->create('MODIngrediente');	
		if($this->objParam->insertar('id_ingrediente')){
			$this->res=$this->objFunc->insertarIngrediente($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarIngrediente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarIngrediente(){
			$this->objFunc=$this->create('MODIngrediente');	
		$this->res=$this->objFunc->eliminarIngrediente($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>