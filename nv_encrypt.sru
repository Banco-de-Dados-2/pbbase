HA$PBExportHeader$nv_encrypt.sru
forward
global type nv_encrypt from nv_ancobject
end type
end forward

global type nv_encrypt from nv_ancobject
end type
global nv_encrypt nv_encrypt

forward prototypes
public function string of_cryptpw (string pw)
public function boolean of_validarpw (string pw, string pwcrypt)
end prototypes

public function string of_cryptpw (string pw);String ls_sql, retorno
nv_DataStore lds

ls_sql = "select " +&
"     pwhash as ret " +&
"from " +&
"    (select " +&
"         crypt('" + pw + "', gen_salt('md5')) as pwhash, " +&
"         gen_salt('md5') as gen " +&
"     ) as t1(pwhash)"
	  
lds = Create nv_datastore

lds.of_create_from_sql( ls_sql, TRUE )

If lds.RowCount() > 0 Then
	retorno = uf_null(lds.GetItemString(1,'RET'), '')
Else
	retorno = ''
End If

Destroy(lds)

return retorno
end function

public function boolean of_validarpw (string pw, string pwcrypt);String ls_sql, retorno
nv_DataStore lds

ls_sql = "select Case When PUBLIC.crypt( '" + pw + "', '" + pwCrypt + "') = '" + pwCrypt + "' Then 'T' else 'F' End as ret from public.dummy"
	  
lds = Create nv_datastore

lds.of_create_from_sql( ls_sql, TRUE )

If lds.RowCount() > 0 Then
	retorno = uf_null(lds.GetItemString(1,'RET'), '')
Else
	retorno = ''
End If

Destroy(lds)

return retorno = 'T'
end function

on nv_encrypt.create
call super::create
end on

on nv_encrypt.destroy
call super::destroy
end on

