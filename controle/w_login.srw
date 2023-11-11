HA$PBExportHeader$w_login.srw
forward
global type w_login from w_ancestor
end type
type sle_senha from u_sle within w_login
end type
type sle_usuario from u_sle within w_login
end type
end forward

global type w_login from w_ancestor
integer width = 3067
integer height = 1684
string title = "Login"
sle_senha sle_senha
sle_usuario sle_usuario
end type
global w_login w_login

on w_login.create
int iCurrent
call super::create
this.sle_senha=create sle_senha
this.sle_usuario=create sle_usuario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_senha
this.Control[iCurrent+2]=this.sle_usuario
end on

on w_login.destroy
call super::destroy
destroy(this.sle_senha)
destroy(this.sle_usuario)
end on

type sle_senha from u_sle within w_login
integer x = 855
integer y = 696
integer width = 1303
integer taborder = 20
string text = "Informe a Senha"
boolean password = true
end type

type sle_usuario from u_sle within w_login
integer x = 846
integer y = 476
integer width = 1321
integer taborder = 10
string text = "Informe o Usuario"
end type

