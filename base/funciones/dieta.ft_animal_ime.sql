CREATE OR REPLACE FUNCTION "dieta"."ft_animal_ime" (	
				p_administrador integer, p_id_usuario integer, p_tabla character varying, p_transaccion character varying)
RETURNS character varying AS
$BODY$

/**************************************************************************
 SISTEMA:		Dieta
 FUNCION: 		dieta.ft_animal_ime
 DESCRIPCION:   Funcion que gestiona las operaciones basicas (inserciones, modificaciones, eliminaciones de la tabla 'dieta.tanimal'
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

	v_nro_requerimiento    	integer;
	v_parametros           	record;
	v_id_requerimiento     	integer;
	v_resp		            varchar;
	v_nombre_funcion        text;
	v_mensaje_error         text;
	v_id_animal	integer;
			    
BEGIN

    v_nombre_funcion = 'dieta.ft_animal_ime';
    v_parametros = pxp.f_get_record(p_tabla);

	/*********************************    
 	#TRANSACCION:  'DA_ANI_INS'
 	#DESCRIPCION:	Insercion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:34:55
	***********************************/

	if(p_transaccion='DA_ANI_INS')then
					
        begin
        	--Sentencia de la insercion
        	insert into dieta.tanimal(
			estado_reg,
			tip_raza,
			descripcion,
			edad,
			raza,
			id_usuario_reg,
			usuario_ai,
			fecha_reg,
			id_usuario_ai,
			id_usuario_mod,
			fecha_mod
          	) values(
			'activo',
			v_parametros.tip_raza,
			v_parametros.descripcion,
			v_parametros.edad,
			v_parametros.raza,
			p_id_usuario,
			v_parametros._nombre_usuario_ai,
			now(),
			v_parametros._id_usuario_ai,
			null,
			null
							
			
			
			)RETURNING id_animal into v_id_animal;
			
			--Definicion de la respuesta
			v_resp = pxp.f_agrega_clave(v_resp,'mensaje','animal almacenado(a) con exito (id_animal'||v_id_animal||')'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_animal',v_id_animal::varchar);

            --Devuelve la respuesta
            return v_resp;

		end;

	/*********************************    
 	#TRANSACCION:  'DA_ANI_MOD'
 	#DESCRIPCION:	Modificacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:34:55
	***********************************/

	elsif(p_transaccion='DA_ANI_MOD')then

		begin
			--Sentencia de la modificacion
			update dieta.tanimal set
			tip_raza = v_parametros.tip_raza,
			descripcion = v_parametros.descripcion,
			edad = v_parametros.edad,
			raza = v_parametros.raza,
			id_usuario_mod = p_id_usuario,
			fecha_mod = now(),
			id_usuario_ai = v_parametros._id_usuario_ai,
			usuario_ai = v_parametros._nombre_usuario_ai
			where id_animal=v_parametros.id_animal;
               
			--Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','animal modificado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_animal',v_parametros.id_animal::varchar);
               
            --Devuelve la respuesta
            return v_resp;
            
		end;

	/*********************************    
 	#TRANSACCION:  'DA_ANI_ELI'
 	#DESCRIPCION:	Eliminacion de registros
 	#AUTOR:		admin	
 	#FECHA:		18-09-2014 19:34:55
	***********************************/

	elsif(p_transaccion='DA_ANI_ELI')then

		begin
			--Sentencia de la eliminacion
			delete from dieta.tanimal
            where id_animal=v_parametros.id_animal;
               
            --Definicion de la respuesta
            v_resp = pxp.f_agrega_clave(v_resp,'mensaje','animal eliminado(a)'); 
            v_resp = pxp.f_agrega_clave(v_resp,'id_animal',v_parametros.id_animal::varchar);
              
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
ALTER FUNCTION "dieta"."ft_animal_ime"(integer, integer, character varying, character varying) OWNER TO postgres;
