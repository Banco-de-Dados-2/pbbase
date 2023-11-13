HA$PBExportHeader$u_uo.sru
forward
global type u_uo from userobject
end type
end forward

global type u_uo from userobject
integer width = 503
integer height = 864
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event post_constructor ( )
end type
global u_uo u_uo

type variables
string is_estado
m_edit im_edit
end variables
forward prototypes
public subroutine of_inicializar ()
public subroutine of_incluir ()
public subroutine of_excluir ()
public subroutine of_gravar ()
public subroutine of_limpar ()
public function boolean of_validar ()
public subroutine of_set_estado (string as_estado)
public subroutine of_set_menu (m_edit am)
end prototypes

event post_constructor();of_inicializar()
end event

public subroutine of_inicializar ();
end subroutine

public subroutine of_incluir ();//
end subroutine

public subroutine of_excluir ();//
end subroutine

public subroutine of_gravar ();//
end subroutine

public subroutine of_limpar ();//
end subroutine

public function boolean of_validar ();return True
end function

public subroutine of_set_estado (string as_estado);is_estado = as_estado
end subroutine

public subroutine of_set_menu (m_edit am); im_edit = am
end subroutine

event constructor;//

Post event post_constructor()
end event

on u_uo.create
end on

on u_uo.destroy
end on

