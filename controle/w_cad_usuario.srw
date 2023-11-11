HA$PBExportHeader$w_cad_usuario.srw
forward
global type w_cad_usuario from w_ancestor
end type
type tab_funcionario from tab within w_cad_usuario
end type
type tabpage_pesquisa from uo_pesquisa_funcionario within tab_funcionario
end type
type tabpage_pesquisa from uo_pesquisa_funcionario within tab_funcionario
end type
type tabpage_cadastro from uo_cad_funcionario within tab_funcionario
end type
type tabpage_cadastro from uo_cad_funcionario within tab_funcionario
end type
type tab_funcionario from tab within w_cad_usuario
tabpage_pesquisa tabpage_pesquisa
tabpage_cadastro tabpage_cadastro
end type
end forward

global type w_cad_usuario from w_ancestor
integer width = 3831
integer height = 2616
string title = ""
string menuname = ""
windowtype windowtype = main!
string icon = ""
boolean clientedge = true
tab_funcionario tab_funcionario
end type
global w_cad_usuario w_cad_usuario

on w_cad_usuario.create
int iCurrent
call super::create
this.tab_funcionario=create tab_funcionario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_funcionario
end on

on w_cad_usuario.destroy
call super::destroy
destroy(this.tab_funcionario)
end on

event post_open;call super::post_open;m_edit.Hide()

Return 1
end event

event ue_incluir;call super::ue_incluir;If tab_funcionario.Selectedtab = 2 Then
	tab_funcionario.tabpage_cadastro.of_incluir( )
End If
end event

event activate;call super::activate;ParentWindow().Dynamic of_set_window( this )
end event

type tab_funcionario from tab within w_cad_usuario
integer x = 59
integer y = 36
integer width = 3680
integer height = 2396
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean showpicture = false
integer selectedtab = 2
tabpage_pesquisa tabpage_pesquisa
tabpage_cadastro tabpage_cadastro
end type

on tab_funcionario.create
this.tabpage_pesquisa=create tabpage_pesquisa
this.tabpage_cadastro=create tabpage_cadastro
this.Control[]={this.tabpage_pesquisa,&
this.tabpage_cadastro}
end on

on tab_funcionario.destroy
destroy(this.tabpage_pesquisa)
destroy(this.tabpage_cadastro)
end on

type tabpage_pesquisa from uo_pesquisa_funcionario within tab_funcionario
integer x = 18
integer y = 112
integer width = 3643
integer height = 2268
string text = "Pesquisa"
end type

type tabpage_cadastro from uo_cad_funcionario within tab_funcionario
integer x = 18
integer y = 112
integer width = 3643
integer height = 2268
string text = "Cadastro"
end type

