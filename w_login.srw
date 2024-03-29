HA$PBExportHeader$w_login.srw
forward
global type w_login from w_ancestor
end type
type st_logo from u_st within w_login
end type
type cb_sair from u_cb within w_login
end type
type cb_logar from u_cb within w_login
end type
type sle_senha from u_sle within w_login
end type
type sle_usuario from u_sle within w_login
end type
end forward

global type w_login from w_ancestor
integer width = 1947
integer height = 1252
string title = "Login"
string menuname = ""
windowtype windowtype = main!
st_logo st_logo
cb_sair cb_sair
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
ls_login = Trim(uf_null(sle_usuario.text, ''))
ls_senha = Trim(uf_null(sle_senha.text, '')) 

If Lower(ls_login) = 'dev' And gb_desenv = True Then 
	If inv_login.of_logarDev() Then
		Open(w_home)
		Close(this)
		Return
	Else
		HALT
		Return
	End If
End If

inv_login.of_set_login(sle_usuario.text, sle_senha.text)

If inv_login.of_logar() Then
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
this.st_logo=create st_logo
this.cb_sair=create cb_sair
this.cb_logar=create cb_logar
this.sle_senha=create sle_senha
this.sle_usuario=create sle_usuario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_logo
this.Control[iCurrent+2]=this.cb_sair
this.Control[iCurrent+3]=this.cb_logar
this.Control[iCurrent+4]=this.sle_senha
this.Control[iCurrent+5]=this.sle_usuario
end on

on w_login.destroy
call super::destroy
destroy(this.st_logo)
destroy(this.cb_sair)
destroy(this.cb_logar)
destroy(this.sle_senha)
destroy(this.sle_usuario)
end on

event open;call super::open;inv_login = CREATE nv_login

This.SetFocus( )

sle_usuario.SetFocus( )
end event

event close;call super::close;Destroy(inv_login)
end event

event key;call super::key;If gb_desenv Then
	If key = KeyEnter! and keyflags = 2 Then
		cb_logar.event clicked( )
	End If
End If

If key = KeyW! and keyflags = 2 Then
	Halt
End If
end event

type st_logo from u_st within w_login
integer x = 183
integer y = 144
integer width = 1513
integer height = 196
integer taborder = 10
integer textsize = -36
string facename = "Microsoft Sans Serif"
string text = "VirtualBusiness"
end type

type cb_sair from u_cb within w_login
integer x = 288
integer y = 880
integer width = 530
integer taborder = 50
string text = "&Sair"
boolean cancel = true
end type

event clicked;call super::clicked;Halt
end event

type cb_logar from u_cb within w_login
integer x = 1061
integer y = 880
integer width = 530
integer taborder = 40
string text = "&Logar"
end type

event clicked;call super::clicked;of_logar() 
end event

type sle_senha from u_sle within w_login
integer x = 288
integer y = 664
integer width = 1303
integer taborder = 30
string text = "Senha"
end type

event losefocus;call super::losefocus;If this.Text = "" Then
	this.Password = False
	this.Text = "Senha"
End If
end event

event getfocus;call super::getfocus;If this.Text = "Senha" And this.Password = False Then
	this.Text = ""
	this.Password = True
End If
end event

type sle_usuario from u_sle within w_login
integer x = 288
integer y = 520
integer width = 1303
integer taborder = 20
string text = "Usu$$HEX1$$e100$$ENDHEX$$rio"
end type

event losefocus;call super::losefocus;If this.Text = "" Then
	this.Text = "Usu$$HEX1$$e100$$ENDHEX$$rio"
End If
end event

event getfocus;call super::getfocus;If this.Text = "Usu$$HEX1$$e100$$ENDHEX$$rio" Then
	this.Text = ""
End If
end event

