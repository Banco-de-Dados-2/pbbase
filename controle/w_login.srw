HA$PBExportHeader$w_login.srw
forward
global type w_login from w_ancestor
end type
type cb_logar from u_cb within w_login
end type
type sle_senha from u_sle within w_login
end type
type sle_usuario from u_sle within w_login
end type
end forward

global type w_login from w_ancestor
integer width = 3067
integer height = 1608
string title = "Login"
string menuname = ""
windowtype windowtype = main!
cb_logar cb_logar
sle_senha sle_senha
sle_usuario sle_usuario
end type
global w_login w_login

type variables
nv_login inv_login
end variables

forward prototypes
public subroutine of_logar ()
end prototypes

public subroutine of_logar ();String ls_login, ls_senha
ls_login = Trim(uf_null( This.sle_usuario.text, '' ) )
ls_senha = Trim(uf_null( This.sle_senha.text, '' ) ) 

If ls_login = 'dev' And gb_desenv = True Then 
	inv_login.of_logarDev()
	Open(w_home)
	Close(this)
	Return
End If

inv_login.of_set_login( This.sle_usuario.text, This.sle_senha.text )

If inv_login.of_logar( ) Then
	inv_login.of_set_transaction()
	Open(w_home)
	Close(this)
Else
	msg('Usuario ou Senha Invalidas')
End If
end subroutine

on w_login.create
int iCurrent
call super::create
this.cb_logar=create cb_logar
this.sle_senha=create sle_senha
this.sle_usuario=create sle_usuario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_logar
this.Control[iCurrent+2]=this.sle_senha
this.Control[iCurrent+3]=this.sle_usuario
end on

on w_login.destroy
call super::destroy
destroy(this.cb_logar)
destroy(this.sle_senha)
destroy(this.sle_usuario)
end on

event open;call super::open;inv_login = CREATE nv_login
end event

event close;call super::close;Destroy(inv_login)
end event

event key;call super::key;
If gb_desenv Then
	If key = KeyEnter! and keyflags = 2 Then
		cb_logar.event clicked( )
	End If
End If
end event

type cb_logar from u_cb within w_login
integer x = 782
integer y = 932
integer width = 1303
integer taborder = 30
string text = "Logar"
end type

event clicked;call super::clicked;of_logar() 
end event

type sle_senha from u_sle within w_login
integer x = 782
integer y = 620
integer width = 1303
integer taborder = 20
string text = ""
boolean password = true
end type

type sle_usuario from u_sle within w_login
integer x = 773
integer y = 476
integer width = 1321
integer taborder = 10
string text = ""
end type

