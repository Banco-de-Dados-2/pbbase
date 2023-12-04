HA$PBExportHeader$nv_transaction.sru
forward
global type nv_transaction from transaction
end type
end forward

global type nv_transaction from transaction
end type
global nv_transaction nv_transaction

forward prototypes
public subroutine of_connect ()
public subroutine of_disconnect ()
end prototypes

public subroutine of_connect ();// Profile conexao
this.DBMS = "ODBC"
this.AutoCommit = False
this.DBParm = "ConnectString='DSN=PostgreSQL35W;UID=postgres;PWD=postgres'"

CONNECT USING this;
end subroutine

public subroutine of_disconnect ();DISCONNECT USING this;
end subroutine

on nv_transaction.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_transaction.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

