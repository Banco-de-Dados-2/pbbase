HA$PBExportHeader$nv_login.sru
forward
global type nv_login from nv_ancobject
end type
end forward

global type nv_login from nv_ancobject
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
public subroutine of_logardev ()
end prototypes

public function boolean of_validar_login ();If is_login = '' Then Return False
	
If is_senha = '' Then Return False

Return True
end function

public function boolean of_logar ();nv_dataStore lds_login

If Not of_validar_login() Then Return False

lds_login = of_create_lds_login()

If lds_login.RowCount() <= 0 Then Return False

If lds_login.GetItemString( 1, 'fun_senha') = is_senha Then 
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
end function

public function nv_datastore of_create_lds_login ();nv_dataStore lds_login

lds_login = CREATE nv_dataStore
lds_login.of_create_from_sql( &
"SELECT fun_cpf, fun_senha, fun_funcao FROM DBA.TB_FUNCIONARIOS WHERE fun_cpf = '" + is_login + "'", True )

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

public subroutine of_logardev ();DISCONNECT USING SQLCA;

// Profile USER
SQLCA.DBMS = "ODBC"
SQLCA.AutoCommit = False
SQLCA.DBParm = "ConnectString='DSN=PostgreSQL35W;UID='postgres';PWD='postgres'"

CONNECT USING SQLCA;
end subroutine

on nv_login.create
call super::create
end on

on nv_login.destroy
call super::destroy
end on

