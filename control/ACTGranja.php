<?php
/**
*@package pXP
*@file gen-ACTGranja.php
*@author  (admin)
*@date 17-09-2014 18:39:06
*@description Clase que recibe los parametros enviados por la vista para mandar a la capa de Modelo
*/

class ACTGranja extends ACTbase{    
			
	function listarGranja(){
		$this->objParam->defecto('ordenacion','id_granja');

		$this->objParam->defecto('dir_ordenacion','asc');
		if($this->objParam->getParametro('tipoReporte')=='excel_grid' || $this->objParam->getParametro('tipoReporte')=='pdf_grid'){
			$this->objReporte = new Reporte($this->objParam,$this);
			$this->res = $this->objReporte->generarReporteListado('MODGranja','listarGranja');
		} else{
			$this->objFunc=$this->create('MODGranja');
			
			$this->res=$this->objFunc->listarGranja($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
				
	function insertarGranja(){
		$this->objFunc=$this->create('MODGranja');	
		if($this->objParam->insertar('id_granja')){
			$this->res=$this->objFunc->insertarGranja($this->objParam);			
		} else{			
			$this->res=$this->objFunc->modificarGranja($this->objParam);
		}
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
						
	function eliminarGranja(){
			$this->objFunc=$this->create('MODGranja');	
		$this->res=$this->objFunc->eliminarGranja($this->objParam);
		$this->res->imprimirRespuesta($this->res->generarJson());
	}
			
}

?>