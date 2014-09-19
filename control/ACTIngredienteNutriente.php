<?php
/**
*@package pXP
*@file gen-ACTIngredienteNutriente.php
*@author  (admin)
*@date 17-09-2014 21:31:27
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTIngredienteNutriente extends ACTbase{    
			
	function listarIngredienteNutriente(){
		$this->objParam->defecto('ordenacion','id_ingrediente_nutriente');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('id_ingrediente')!=''){
	    	$this->objParam->addFiltro("innu.id_ingrediente = ".$this->objParam->getParametro('id_ingrediente'));	
		}
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODIngredienteNutriente','listarIngredienteNutriente');
		} else{
			$this->objFunc=$this->create('MODIngredienteNutriente');
			
			$this->res=$this->objFunc->listarIngredienteNutriente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarIngredienteNutriente(){
		$this->objFunc=$this->create('MODIngredienteNutriente');	
		if($this->objParam->insertar('id_ingrediente_nutriente')){
			$this->res=$this->objFunc->insertarIngredienteNutriente($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarIngredienteNutriente($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarIngredienteNutriente(){
			$this->objFunc=$this->create('MODIngredienteNutriente');	
		$this->res=$this->objFunc->eliminarIngredienteNutriente($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>