Rem Script by SRIVENU KADIYALA - mail - srivenu@hotmail.com

 
col bug_id head "Bug ID" form 99999999
col bug_number head "Bug Number" form 99999999
col application_short_name head "App" form a10
col aru_release_name head "ARU|Release" form a10
col bug_status head "Bug|Status" form a10
col success_flag head "Success?" form a1
col Applied_On head "Applied On" form a20
col last_update_date head "Last Update Date" form a20

SELECT 	bug_id,
	bug_number,
	application_short_name,
	aru_release_name,
	bug_status,
	success_flag,
	to_char(creation_date, 'DD-MON-YYYY HH:MI') "Applied_On",
	to_char(last_update_date, 'DD-MON-YYYY HH:MI') last_update_date
FROM 	APPLSYS.ad_bugs
where	bug_number=trim('&1')
ORDER 	by 2
/

col applied_patch_id head "Patch ID"
col patch_name head "Patch Name" form a10
col patch_type head "Patch|Type" form a16
col rapid_install head "Rapid|install" form a10
col driver_file_name head "Driver File name" form a15
col orig_patch_name head "Orig|Patch|Name" form a15
col platform head "Platform" form a10
col Patch_Applied_On head "Patch Applied On" form a20

SELECT 	aap.applied_patch_id, 
	aap.patch_name, 
	aap.patch_type, 
	decode(aap.rapid_installed_flag, 'Y', 'Yes', 'No') "rapid_install", 
	apd.driver_file_name, 
	apd.orig_patch_name, 
	apd.platform, 
	to_char(apd.creation_date, 'DD-MON-YYYY HH:MI') "Patch_Applied_On" 
FROM 	APPLSYS.ad_applied_patches aap, APPLSYS.ad_patch_drivers apd 
WHERE 	aap.applied_patch_id = apd.applied_patch_id 
and	apd.applied_patch_id = trim('&1')
ORDER 	by 8
/
 


