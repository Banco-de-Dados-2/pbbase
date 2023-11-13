HA$PBExportHeader$u_dw.sru
forward
global type u_dw from datawindow
end type
end forward

global type u_dw from datawindow
integer width = 1696
integer height = 848
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_key pbm_dwnkey
end type
global u_dw u_dw

type variables
w_ancestor iw_pai
end variables

forward prototypes
public subroutine of_set_color_background ()
public subroutine of_bloq_campo (string as_campos[], boolean ab_bloq)
public subroutine of_set_w_pai (w_ancestor aw_window)
public function integer of_update ()
end prototypes

event ue_key;//
end event

public subroutine of_set_color_background ();//
this.Modify("DataWindow.Color='"+ String(iw_pai.BackColor) +"'")
end subroutine

public subroutine of_bloq_campo (string as_campos[], boolean ab_bloq);Long ll_tam, ll_for
String ls_Protect, ls_BackMode, ls_enabled
ll_tam = UpperBound(as_campos)

If ab_bloq Then
	ls_Protect = '1'
	ls_BackMode = '1'
	ls_enabled = 'No'
Else
	ls_Protect = '0'
	ls_BackMode = '0'	
	ls_enabled = 'Yes'
End If

For ll_for = 1 To ll_tam
	try 
		If left(as_campos[ll_for], 2) = 'b_' Then
			this.Modify(as_campos[ll_for]+".Enabled='"+ ls_enabled + "'")
		Else 
			this.Modify(as_campos[ll_for]+".Protect='"+ ls_Protect + "'")
			this.Modify(as_campos[ll_for]+".Background.Mode='" + ls_BackMode + "'")			
		End If
	catch ( Exception e )
		msg(e.Text)
	end try
Next
end subroutine

public subroutine of_set_w_pai (w_ancestor aw_window);iw_pai = aw_window
end subroutine

public function integer of_update ();long ll_retorno

try 
	ll_retorno = this.update()
catch ( Exception e )
	Msg(e.Text)
	ll_retorno = -1
finally
	return ll_retorno
end try
	

end function

on u_dw.create
end on

on u_dw.destroy
end on

