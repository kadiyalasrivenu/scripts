Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com
col namespace head "Namespace" form a15
col pins head "Pins" form 9999999999999
col pinhits head "PinHits" form 9999999999999
col reloads head "Reloads" form 9999999999999
col invalidations head "Invalidations" form 9999999999999
col hitratio head "HitRatio" form 999.99

SELECT namespace, pins, pinhits, reloads, invalidations, 
	 pinhits/decode(pins,null,1,0,1,pins) hitratio
FROM V$LIBRARYCACHE
ORDER BY namespace
/