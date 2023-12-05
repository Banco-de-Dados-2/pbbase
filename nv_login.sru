HA$PBExportHeader$nv_login.sru
forward
global type nv_login from nv_ancobject
end type
end forward

global type nv_login from nv_ancobject
event type boolean of_validar_senha ( string as_senha,  string as_senhacrypt )
end type
global nv_login nv_login

type variables
Private String is_login, is_senha, is_role
Private:
	String GERENTE = 'Gerente', ESTOQUISTA = 'Estoquista', VENDEDOR = 'Vendedor', DIRETOR = 'Diretor'
end variables

forward prototypes
public function boolean of_validar_login ()
public function boolean of_logar ()
public function nv_datastore of_create_lds_login ()
public subroutine of_set_login (string as_login, string as_senha)
public subroutine of_set_transaction ()
public function Boolean of_logardev ()
public function Boolean of_validar_senha (string as_senha, string as_senhacrypt)
end prototypes

public function boolean of_validar_login ();If is_login = '' Then Return False
	
If is_senha = '' Then Return False

Return True
end function

public function boolean of_logar ();nv_dataStore lds_login

If Not of_validar_login() Then Return False

lds_login = of_create_lds_login()

If lds_login.RowCount() <= 0 Then Return False


If of_Validar_Senha( is_senha, lds_login.GetItemString( 1, 'fun_senha') ) Then 
	Choose Case lds_login.GetItemString( 1, 'fun_funcao')
		case DIRETOR
			is_role = 'd'
		case VENDEDOR
			is_role = 'v'
		case ESTOQUISTA
			is_role = 'e'
		case GERENTE
			is_role = 'g'
	End Choose
	Return True
End If

Destroy(lds_login)
end function

public function nv_datastore of_create_lds_login ();nv_dataStore lds_login
String ls_sql

ls_sql = "SELECT fun_cpf, fun_senha, fun_funcao FROM DBA.TB_FUNCIONARIOS WHERE fun_cpf = '" + is_login + "'"

lds_login = CREATE nv_dataStore
lds_login.of_create_from_sql( ls_sql , True )

return lds_login
end function

public subroutine of_set_login (string as_login, string as_senha);is_login = as_login
is_senha = as_senha
end subroutine

public subroutine of_set_transaction ();DISCONNECT USING SQLCA;

// Profile USER
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=PostgreSQL35W;UID=" + is_role + is_login + ";PWD=" + is_senha + "'"

CONNECT USING SQLCA;
end subroutine

public function Boolean of_logardev ();DISCONNECT USING SQLCA;

// Profile conexao
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=PostgreSQL35W;UID=postgres;PWD=postgres'"

CONNECT USING SQLCA;

If SQLCA.SQLCode = -1 Then
	Msg("Erro ao conectar")
	Return False
Else
	Return True
End If

end function

public function Boolean of_validar_senha (string as_senha, string as_senhacrypt);nv_Encrypt ln_Encrypt

ln_Encrypt = Create nv_Encrypt 

return ln_Encrypt.of_ValidarPW( as_senha , as_senhaCrypt )

end function

on nv_login.create
call super::create
end on

on nv_login.destroy
call super::destroy
end on

