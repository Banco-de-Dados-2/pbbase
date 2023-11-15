HA$PBExportHeader$w_pesquisa.srw
forward
global type w_pesquisa from w_ancestor
end type
type dw_pesquisa from u_dw within w_pesquisa
end type
type dw_filtro from u_dw within w_pesquisa
end type
end forward

global type w_pesquisa from w_ancestor
integer width = 2537
integer height = 1644
string title = "Pesquisa"
string menuname = ""
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pesquisa dw_pesquisa
dw_filtro dw_filtro
end type
global w_pesquisa w_pesquisa

type variables
w_ancestor iw_pai 
end variables

forward prototypes
public function boolean of_gerar_sql (string as_tabela)
public subroutine of_retorna (boolean ab_valida, long row)
end prototypes

public function boolean of_gerar_sql (string as_tabela);String ls_sql 
Choose Case as_tabela
	Case	 'dba.tb_fornecedor'
		ls_sql = "select for_codigo as codigo, for_descricao as descricao from dba.tb_fornecedor"
	Case 'dba.tb_produto'
		ls_sql = "select pro_codigo as codigo, pro_descricao as descricao from dba.tb_produto"
	Case 'dba.tb_funcionarios'
		ls_sql = "select fun_codigo as codigo, fun_nome as descricao from dba.tb_funcionarios"
	Case Else
		Return False
End Choose

If dw_pesquisa.SetSqlSelect( ls_sql ) = 1 Then
	dw_pesquisa.SetTransObject( SQLCA )
	return dw_pesquisa.Retrieve() > 0
Else
	Return False
End If
end function

public subroutine of_retorna (boolean ab_valida, long row);s_parm lst_envia

lst_envia.Boolean = { ab_valida }
If ab_valida Then
	lst_envia.Long = { dw_pesquisa.GetItemNumber(row, 'codigo') }
	lst_envia.String = { dw_pesquisa.GetItemString(row, 'descricao') }
End If

CloseWithReturn( This , lst_envia )
end subroutine

on w_pesquisa.create
int iCurrent
call super::create
this.dw_pesquisa=create dw_pesquisa
this.dw_filtro=create dw_filtro
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pesquisa
this.Control[iCurrent+2]=this.dw_filtro
end on

on w_pesquisa.destroy
call super::destroy
destroy(this.dw_pesquisa)
destroy(this.dw_filtro)
end on

event open;call super::open;s_parm st_recebe

st_recebe = Message.powerobjectparm

iw_pai = ParentWindow()

dw_filtro.of_set_w_pai( iw_pai )
dw_filtro.of_set_color_background( )

dw_filtro.Reset()
dw_filtro.InsertRow(0)

If UpperBound(st_recebe.String) > 0 then
	If Not Of_gerar_sql( st_recebe.String[1] ) Then
		Msg("Erro ao buscar dados!")
		s_parm lst_retorno
		lst_retorno.boolean = {false}
		CloseWithReturn(This, lst_retorno )
	End If
End If
end event

type dw_pesquisa from u_dw within w_pesquisa
integer x = 27
integer y = 240
integer width = 2464
integer height = 1224
integer taborder = 20
string dataobject = "d_pesquisa"
end type

event doubleclicked;call super::doubleclicked;If row > 0 Then
	of_retorna(True,  row )
End If
end event

type dw_filtro from u_dw within w_pesquisa
integer x = 27
integer y = 60
integer width = 2450
integer height = 112
integer taborder = 10
string dataobject = "d_filtro_pesquisa"
boolean border = false
end type

