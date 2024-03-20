HA$PBExportHeader$w_ancestor.srw
forward
global type w_ancestor from window
end type
type mdi_1 from mdiclient within w_ancestor
end type
end forward

global type w_ancestor from window
integer width = 6309
integer height = 2032
boolean titlebar = true
string title = "Ancestor"
string menuname = "m_edit"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = mdihelp!
long backcolor = 67108864
string icon = "imagens\logo.ico"
boolean center = true
event type long post_open ( )
event ue_incluir ( )
event ue_excluir ( )
event ue_gravar ( )
event ue_limpar ( )
mdi_1 mdi_1
end type
global w_ancestor w_ancestor

type variables
Boolean ib_fechando 
String is_estado
end variables

forward prototypes
public subroutine of_set_estado (string as_estado)
public function string of_get_estado ()
end prototypes

event type long post_open();//

return 1
end event

event ue_excluir();//
end event

event ue_gravar();//
end event

event ue_limpar();//
end event

public subroutine of_set_estado (string as_estado);
end subroutine

public function string of_get_estado ();return is_estado
end function

on w_ancestor.create
if this.MenuName = "m_edit" then this.MenuID = create m_edit
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_ancestor.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;This.Icon = 'imagens\logo.ico'

This.Post event post_open( )
end event

event close;ib_fechando = True
end event

type mdi_1 from mdiclient within w_ancestor
long BackColor=268435456
end type

