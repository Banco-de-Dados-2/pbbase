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
type inv_login from nv_login within w_login
end type
end forward

global type w_login from w_ancestor
integer width = 3067
integer height = 1684
string title = "Login"
cb_logar cb_logar
sle_senha sle_senha
sle_usuario sle_usuario
inv_login inv_login
end type
global w_login w_login

forward prototypes
public subroutine of_logar ()
end prototypes

public subroutine of_logar ();String ls_login, ls_senha

ls_login = Trim(uf_null( This.sle_usuario.text, '' ) )
ls_senha = Trim(uf_null( This.sle_senha.text, '' ) ) 

inv_login.of_set_login( This.sle_usuario.text, This.sle_senha.text )

If inv_login.of_logar( ) Then
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
this.inv_login=create inv_login
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_logar
this.Control[iCurrent+2]=this.sle_senha
this.Control[iCurrent+3]=this.sle_usuario
end on

on w_login.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_logar)
destroy(this.sle_senha)
destroy(this.sle_usuario)
destroy(this.inv_login)
end on

event open;call super::open;inv_login = CREATE nv_login
end event

event close;call super::close;Destroy(inv_login)
end event

type cb_logar from u_cb within w_login
integer x = 1230
integer y = 932
integer taborder = 30
string text = "Logar"
end type

event clicked;call super::clicked;of_logar()
end event

type sle_senha from u_sle within w_login
integer x = 850
integer y = 696
integer width = 1303
integer taborder = 20
string text = ""
boolean password = true
end type

type sle_usuario from u_sle within w_login
integer x = 846
integer y = 476
integer width = 1321
integer taborder = 10
string text = "Informe o Usuario"
end type

type inv_login from nv_login within w_login descriptor "pb_nvo" = "true" 
end type

on inv_login.create
call super::create
end on

on inv_login.destroy
call super::destroy
end on

