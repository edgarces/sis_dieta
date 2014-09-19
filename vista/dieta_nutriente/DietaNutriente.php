<?php
/**
*@package pXP
*@file gen-DietaNutriente.php
*@author  (admin)
*@date 18-09-2014 21:17:39
*@description Archivo con la interfaz de usuario que permite la ejecucion de todas las funcionalidades del sistema
*/

header("content-type: text/javascript; charset=UTF-8");
?>
<script>
Phx.vista.DietaNutriente=Ext.extend(Phx.gridInterfaz,{

	constructor:function(config){
		this.maestro=config.maestro;
    	//llama al constructor de la clase padre
		Phx.vista.DietaNutriente.superclass.constructor.call(this,config);
		this.init();
	},
			
	Atributos:[
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_dieta_nutriente'
			},
			type:'Field',
			form:true 
		},
		{
			//configuracion del componente
			config:{
					labelSeparator:'',
					inputType:'hidden',
					name: 'id_dieta'
			},
			type:'Field',
			form:true 
		},
		{
   			config:{
   				name:'id_nutriente',
   				fieldLabel:'Nutriente',
   				allowBlank:true,
   				gwidth: 100,
   				emptyText:'Elija nutriente...',
   				store: new Ext.data.JsonStore({

					url: '../../sis_dieta/control/Nutriente/listarNutriente',
					id: 'id_nutriente',
					root: 'datos',
					sortInfo:{
						field: 'nombre',
						direction: 'ASC'
					},
					totalProperty: 'total',
					fields: ['id_nutriente','nombre'],
					// turn on remote sorting
					remoteSort: true,
					baseParams:{par_filtro:'nombre'}
				}),
   				valueField: 'id_nutriente',
   				displayField: 'nombre',
   				gdisplayField:'nombre',//dibuja el campo extra de la consulta al hacer un inner join con orra tabla
   				tpl:'<tpl for="."><div class="x-combo-list-item"><p>{nombre}</p></div></tpl>',
   				hiddenName: 'id_nutriente',
   				forceSelection:true,
   				typeAhead: true,
       			triggerAction: 'all',
       			lazyRender:true,
   				mode:'remote',
   				pageSize:10,
   				queryDelay:1000,
   				width:250,
   				gwidth:280,
   				minChars:2,
   				renderer:function (value, p, record){return String.format('{0}', record.data['nombre']);}
   			},
   			//type:'TrigguerCombo',
   			type:'ComboBox',
   			id_grupo:0,
   			filters:{	
   				        pfiltro:'nombre',
   						type:'string'
   					},
   		   
   			grid:true,
   			form:true
       	},
       	{
			config:{
				name: 'porcentaje',
				fieldLabel: 'Porcentaje',
				allowBlank: false,
				anchor: '30%',
				gwidth: 100,
				maxLength:3
			},
				type:'TextField',
				filters:{pfiltro:'dinu.porcentaje',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'dieta_max',
				fieldLabel: 'Dieta maximo',
				allowBlank: false,
				anchor: '30%',
				gwidth: 100,
				maxLength:1245187
			},
				type:'TextField',
				filters:{pfiltro:'dinu.dieta_max',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'dieta_min',
				fieldLabel: 'Dieta minimo',
				allowBlank: false,
				anchor: '30%',
				gwidth: 100,
				maxLength:1245187
			},
				type:'TextField',
				filters:{pfiltro:'dinu.dieta_min',type:'string'},
				id_grupo:1,
				grid:true,
				form:true
		},
		{
			config:{
				name: 'estado_reg',
				fieldLabel: 'Estado Reg.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:10
			},
				type:'TextField',
				filters:{pfiltro:'dinu.estado_reg',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'id_usuario_ai',
				fieldLabel: '',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'dinu.id_usuario_ai',type:'numeric'},
				id_grupo:1,
				grid:false,
				form:false
		},
		{
			config:{
				name: 'usr_reg',
				fieldLabel: 'Creado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu1.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usuario_ai',
				fieldLabel: 'Funcionaro AI',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:300
			},
				type:'TextField',
				filters:{pfiltro:'dinu.usuario_ai',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_reg',
				fieldLabel: 'Fecha creación',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'dinu.fecha_reg',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'usr_mod',
				fieldLabel: 'Modificado por',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
				maxLength:4
			},
				type:'Field',
				filters:{pfiltro:'usu2.cuenta',type:'string'},
				id_grupo:1,
				grid:true,
				form:false
		},
		{
			config:{
				name: 'fecha_mod',
				fieldLabel: 'Fecha Modif.',
				allowBlank: true,
				anchor: '80%',
				gwidth: 100,
							format: 'd/m/Y', 
							renderer:function (value,p,record){return value?value.dateFormat('d/m/Y H:i:s'):''}
			},
				type:'DateField',
				filters:{pfiltro:'dinu.fecha_mod',type:'date'},
				id_grupo:1,
				grid:true,
				form:false
		}
	],
	tam_pag:50,	
	title:'dieta nutriente',
	ActSave:'../../sis_dieta/control/DietaNutriente/insertarDietaNutriente',
	ActDel:'../../sis_dieta/control/DietaNutriente/eliminarDietaNutriente',
	ActList:'../../sis_dieta/control/DietaNutriente/listarDietaNutriente',
	id_store:'id_dieta_nutriente',
	fields: [
		{name:'id_dieta_nutriente', type: 'numeric'},
		{name:'id_nutriente', type: 'numeric'},
		{name:'id_dieta', type: 'numeric'},
		{name:'estado_reg', type: 'string'},
		{name:'id_usuario_ai', type: 'numeric'},
		{name:'id_usuario_reg', type: 'numeric'},
		{name:'usuario_ai', type: 'string'},
		{name:'fecha_reg', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'id_usuario_mod', type: 'numeric'},
		{name:'fecha_mod', type: 'date',dateFormat:'Y-m-d H:i:s.u'},
		{name:'usr_reg', type: 'string'},
		{name:'usr_mod', type: 'string'},
		{name:'nombre', type: 'string'},
		{name:'dieta_max', type: 'numeric'},
		{name:'dieta_min', type: 'numeric'},
		{name:'porcentaje', type: 'numeric'},
		
	],
	sortInfo:{
		field: 'id_dieta_nutriente',
		direction: 'ASC'
	},
	bdel:true,
	bsave:true,
	
	
	loadValoresIniciales:function(){
    	Phx.vista.DietaNutriente.superclass.loadValoresIniciales.call(this);
		this.getComponente('id_dieta').setValue(this.maestro.id_dieta);
	},
	
	onReloadPage:function(m){
		this.maestro=m;
		this.store.baseParams={id_dieta:this.maestro.id_dieta};
		this.load({params:{start:0, limit:50}})
		
	},
	
	
	
	
	}
)
</script>
		
		