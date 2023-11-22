HA$PBExportHeader$w_msg_erro.srw
forward
global type w_msg_erro from w_ancestor
end type
type cb_fechar from u_cb within w_msg_erro
end type
type mle_msgbanco from u_mle within w_msg_erro
end type
type mle_msgsistema from u_mle within w_msg_erro
end type
type gb_msgsistema from u_gb within w_msg_erro
end type
type gb_msgbanco from u_gb within w_msg_erro
end type
end forward

global type w_msg_erro from w_ancestor
integer width = 2441
integer height = 1688
string title = "Erro de banco"
string menuname = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_fechar cb_fechar
mle_msgbanco mle_msgbanco
mle_msgsistema mle_msgsistema
gb_msgsistema gb_msgsistema
gb_msgbanco gb_msgbanco
end type
global w_msg_erro w_msg_erro

on w_msg_erro.create
int iCurrent
call super::create
this.cb_fechar=create cb_fechar
this.mle_msgbanco=create mle_msgbanco
this.mle_msgsistema=create mle_msgsistema
this.gb_msgsistema=create gb_msgsistema
this.gb_msgbanco=create gb_msgbanco
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_fechar
this.Control[iCurrent+2]=this.mle_msgbanco
this.Control[iCurrent+3]=this.mle_msgsistema
this.Control[iCurrent+4]=this.gb_msgsistema
this.Control[iCurrent+5]=this.gb_msgbanco
end on

on w_msg_erro.destroy
call super::destroy
destroy(this.cb_fechar)
destroy(this.mle_msgbanco)
destroy(this.mle_msgsistema)
destroy(this.gb_msgsistema)
destroy(this.gb_msgbanco)
end on

event open;call super::open;s_Parm ls_Recebe
ls_Recebe = message.PowerObjectParm 

ls_Recebe.String[1] = uf_strtran(ls_Recebe.String[1], '~r~n', Char(13) + Char(10))
ls_Recebe.String[2] = uf_strtran(ls_Recebe.String[2], '~r~n', Char(13) + Char(10))

ls_Recebe.String[1] = uf_strtran(ls_Recebe.String[1], '~r', Char(13) + Char(10))
ls_Recebe.String[2] = uf_strtran(ls_Recebe.String[2], '~r', Char(13) + Char(10))

mle_MsgSistema.Text = trim(ls_Recebe.String[1])
mle_MsgBanco.Text	= ls_Recebe.String[2]
end event

type cb_fechar from u_cb within w_msg_erro
integer x = 1989
integer y = 1464
integer taborder = 30
string text = "&Fechar"
boolean cancel = true
boolean default = true
end type

event clicked;call super::clicked;Close(This.GetParent())
end event

type mle_msgbanco from u_mle within w_msg_erro
integer x = 87
integer y = 812
integer width = 2249
integer height = 584
integer taborder = 20
long backcolor = 67108864
boolean hscrollbar = true
boolean vscrollbar = true
boolean displayonly = true
end type

type mle_msgsistema from u_mle within w_msg_erro
integer x = 87
integer y = 84
integer width = 2249
integer height = 584
integer taborder = 20
long backcolor = 67108864
boolean hscrollbar = true
boolean vscrollbar = true
boolean displayonly = true
end type

type gb_msgsistema from u_gb within w_msg_erro
integer x = 37
integer y = 16
integer width = 2354
integer height = 700
integer taborder = 10
string text = " Mensagem do sistema "
end type

type gb_msgbanco from u_gb within w_msg_erro
integer x = 37
integer y = 736
integer width = 2354
integer height = 700
integer taborder = 20
string text = " Mensagem do Banco de Dados "
end type

