CREATE OR REPLACE FUNCTION dieta.ft_dieta_sel (
  p_administrador integer,
  p_id_usuario integer,
  p_tabla varchar,
  p_transaccion varchar
)
RETURNS varchar AS
$body$
/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_dieta_sel
 DESCRIPCION:   Funcion que devuelve conjuntos de registros de las consultas relacionadas con la tabla 'dieta.tdieta'
 AUTOR: 		 (admin)
 FECHA:	        18-09-2014 19:35:16
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

	v_nombre_funcion = 'dieta.ft_dieta_sel';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_DIE_SEL'
 	#DESCRIPCION:	Consulta de datos
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:35:16
	***********************************/

	if(p_transaccion='DA_DIE_SEL')then
     				
    	begin
    		--Sentencia de la consulta
			v_consulta:='select
						die.id_dieta,
						die.id_animal,
						die.descripcion,
						die.tipo_dieta,
						die.estado_reg,
						die.id_usuario_ai,
						die.id_usuario_reg,
						die.fecha_reg,
						die.usuario_ai,
						die.fecha_mod,
						die.id_usuario_mod,
						usu1.cuenta as usr_reg,
						usu2.cuenta as usr_mod,
                        usu.raza	
						from dieta.tdieta die
						inner join segu.tusuario usu1 on usu1.id_usuario = die.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = die.id_usuario_mod
				        inner join	dieta.tanimal usu on usu.id_animal = usu.id_animal	
                        where  ';
			
			--Definicion de la respuesta
			v_consulta:=v_consulta||v_parametros.filtro;
			v_consulta:=v_consulta||' order by ' ||v_parametros.ordenacion|| ' ' || v_parametros.dir_ordenacion || ' limit ' || v_parametros.cantidad || ' offset ' || v_parametros.puntero;

			--Devuelve la respuesta
			return v_consulta;
						
		end;

	/*********************************    
 	#TRANSACCION:  'DA_DIE_CONT'
 	#DESCRIPCION:	Conteo de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:35:16
	***********************************/

	elsif(p_transaccion='DA_DIE_CONT')then

		begin
			--Sentencia de la consulta de conteo de registros
			v_consulta:='select count(id_dieta)
					    from dieta.tdieta die
						inner join segu.tusuario usu1 on usu1.id_usuario = die.id_usuario_reg
						left join segu.tusuario usu2 on usu2.id_usuario = die.id_usuario_mod
				        inner join	dieta.tanimal usu on usu.id_animal = usu.id_animal	
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