CREATE OR REPLACE FUNCTION dieta.ft_ingrediente_nutriente_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_ingrediente_nutriente_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dieta.tingrediente_nutriente'
 AUTOR: 		 (admin)
 FECHA:	        17-09-2014 21:31:27
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_consulta    		varchar;
	v_parametros  		record;
	v_nombre_funcion   	text;
	v_resp				varchar;
			    
BEGIN

	v_nombre_funcion = 'dieta.ft_ingrediente_nutriente_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_INNU_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:27
	***********************************/

	if(p_transaccion='DA_INNU_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						innu.id_ingrediente_nutriente,
						innu.id_ingrediente,
						innu.id_nutriente,
						innu.porcentaje_nutriente,
						innu.estado_reg,
						innu.id_usuario_ai,
						innu.id_usuario_reg,
						innu.fecha_reg,
						innu.usuario_ai,
						innu.fecha_mod,
						innu.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        usu.nombre	
						from dieta.tingrediente_nutriente innu
						inner join segu.tusuario usu1 on usu1.id_usuario = innu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = innu.id_usuario_mod
                        inner join dieta.tnutriente usu on usu.id_nutriente = innu.id_nutriente
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DA_INNU_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 21:31:27
	***********************************/

	elsif(p_transaccion='DA_INNU_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_ingrediente_nutriente)
					    from dieta.tingrediente_nutriente innu
						inner join segu.tusuario usu1 on usu1.id_usuario = innu.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = innu.id_usuario_mod
                        inner join dieta.tnutriente usu on usu.id_nutriente = innu.id_nutriente
				        where ';
			
			--Definicion de la respuesta		    
			v_consulta:=v_consulta||v_parametros.filtro;

			--Devuelve la respuesta
			return v_consulta;

		end;
					
	else
					     
		raise exception 'Transaccion inexistente';
					         
	end if;
					
EXCEPTION
					
	WHEN OTHERS THEN
			v_resp='';
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje',SQLERRM);
			v_resp = pxp.f_agrega_clave(v_resp,'codigo_error',SQLSTATE);
			v_resp = pxp.f_agrega_clave(v_resp,'procedimientos',v_nombre_funcion);
			raise exception '%',v_resp;
END;
$body$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;