CREATE OR REPLACE FUNCTION "dieta"."ft_animal_sel"(	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$
/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_animal_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dieta.tanimal'
 AUTOR: 		 (admin)
 FECHA:	        18-09-2014 19:34:55
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

	v_nombre_funcion = 'dieta.ft_animal_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_ANI_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:34:55
	***********************************/

	if(p_transaccion='DA_ANI_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						ani.id_animal,
						ani.estado_reg,
						ani.tip_raza,
						ani.descripcion,
						ani.edad,
						ani.raza,
						ani.id_usuario_reg,
						ani.usuario_ai,
						ani.fecha_reg,
						ani.id_usuario_ai,
						ani.id_usuario_mod,
						ani.fecha_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod	
						from dieta.tanimal ani
						inner join segu.tusuario usu1 on usu1.id_usuario = ani.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ani.id_usuario_mod
				        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DA_ANI_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:34:55
	***********************************/

	elsif(p_transaccion='DA_ANI_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_animal)
					    from dieta.tanimal ani
					    inner join segu.tusuario usu1 on usu1.id_usuario = ani.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = ani.id_usuario_mod
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
$BODY$
LANGUAGE 'plpgsql' VOLATILE
COST 100;
ALTER FUNCTION "dieta"."ft_animal_sel"(integer, integer, character varying, character varying) OWNER TO postgres;
