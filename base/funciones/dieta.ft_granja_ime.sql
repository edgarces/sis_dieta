CREATE OR REPLACE FUNCTION "dieta"."ft_granja_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_granja_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dieta.tgranja'
 AUTOR: 		 (admin)
 FECHA:	        17-09-2014 18:39:06
 COMENTARIOS:	
***************************************************************************
 HISTORIAL DE MODIFICACIONES:

 DESCRIPCION:	
 AUTOR:			
 FECHA:		
***************************************************************************/

DECLARE

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_granja	integer;
			    
BEGIN

    v_nombre_funcion = 'dieta.ft_granja_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_GRA_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 18:39:06
	***********************************/

	if(p_transaccion='DA_GRA_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dieta.tgranja(
			descripcion,
			estado_reg,
			nombre,
			id_usuario_ai,
			fecha_reg,
			usuario_ai,
			id_usuario_reg,
			id_usuario_mod,
			fecha_mod
          	) values(
			v_parametros.descripcion,
			'activo',
			v_parametros.nombre,
			v_parametros._id_usuario_ai,
			now(),
			v_parametros._nombre_usuario_ai,
			p_id_usuario,
			null,
			null
							
			
			
			)RETURNING id_granja into v_id_granja;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','granja almacenado(a) con exito (id_granja'||v_id_granja||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_granja',v_id_granja::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DA_GRA_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 18:39:06
	***********************************/

	elsif(p_transaccion='DA_GRA_MOD')then

		begin
			--Sentencia de la modificacion
			update dieta.tgranja set
			descripcion = v_parametros.descripcion,
			nombre = v_parametros.nombre,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_granja=v_parametros.id_granja;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','granja modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_granja',v_parametros.id_granja::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DA_GRA_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		17-09-2014 18:39:06
	***********************************/

	elsif(p_transaccion='DA_GRA_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dieta.tgranja
            where id_granja=v_parametros.id_granja;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','granja eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_granja',v_parametros.id_granja::varchar);
              
            --Devuelve la respuesta
            return v_resp;

		end;
         
	else
     
    	raise exception 'Transaccion inexistente: %',p_transaccion;

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
ALTER FUNCTION "dieta"."ft_granja_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
