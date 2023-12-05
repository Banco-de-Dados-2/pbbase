HA$PBExportHeader$uo_pesquisa_venda.sru
forward
global type uo_pesquisa_venda from u_uo
end type
type dw_produto from u_dw within uo_pesquisa_venda
end type
type dw_venda from u_dw within uo_pesquisa_venda
end type
type cb_ok from u_cb within uo_pesquisa_venda
end type
type gb_venda from u_gb within uo_pesquisa_venda
end type
type dw_filtro from u_dw within uo_pesquisa_venda
end type
type gb_filtros from u_gb within uo_pesquisa_venda
end type
end forward

global type uo_pesquisa_venda from u_uo
integer width = 3671
integer height = 2280
dw_produto dw_produto
dw_venda dw_venda
cb_ok cb_ok
gb_venda gb_venda
dw_filtro dw_filtro
gb_filtros gb_filtros
end type
global uo_pesquisa_venda uo_pesquisa_venda

type variables
string filtro_venda, filtro_funcionario, filtro_produto, filtro_dtini, filtro_dtfim
w_ancestor iw_pai
end variables

forward prototypes
public subroutine of_retrieve ()
public subroutine of_filter (long row, string name)
public subroutine of_inicializar ()
public subroutine of_retrieve_produto (long row)
end prototypes

public subroutine of_retrieve ();String ls_sql, ls_newSql, ls_where_produto = ' 5=5 ', ls_where_geral = ' 1=1 '

ls_sql = dw_venda.getSqlSelect()

ls_newSql = ls_sql

if filtro_produto <> '' Then ls_where_produto += "it.tb_produto_pro_codigo in ( " + filtro_produto + " ) " 

If filtro_venda <> '' Then ls_where_geral += " and dba.tb_vendas.ven_codigo in (" + filtro_venda + ") "
If filtro_funcionario <> '' Then ls_where_geral += " and dba.tb_funcionarios.fun_codigo in(" + filtro_funcionario + ") "
ls_where_geral += " and cast(dba.tb_vendas.ven_horario as date) between '" + filtro_dtini + "' and '" + filtro_dtfim + "'"

ls_newSql = uf_strTrans( ls_newsql , '5=5', ls_where_produto )

ls_newSql = uf_strTrans( ls_newsql , '1=1', ls_where_geral )

dw_venda.SetSqlSelect( ls_newSql )
dw_venda.Retrieve()
dw_venda.SetSqlSelect( ls_Sql )

If dw_venda.rowcount() > 0 Then
	
	ls_sql = dw_produto.GetSqlSelect()
	
	Long ll_vendas[]
	ll_vendas = dw_venda.object.ven_codigo.Primary
	ls_where_produto = ' dba.tb_itens.tb_vendas_ven_codigo in ( ' +  uf_ArrayToString( ll_vendas) + ' )'
	
	ls_newsql = uf_strTrans( ls_sql, '1=1', ls_where_produto )
	
	dw_produto.SetSqlSelect( ls_newSql )
	dw_produto.Retrieve()
	dw_produto.SetSqlSelect( ls_Sql )
	
End If 
end subroutine

public subroutine of_filter (long row, string name);String ls_filter, data

dw_filtro.AcceptText()

Choose Case name
	Case 'ven_codigo'
		data = Trim(uf_null(dw_filtro.GetItemString(1, name ), ''))
		filtro_venda = data
	Case 'pro_codigo'
		data = Trim(uf_null(dw_filtro.GetItemString(1, name ), ''))
		filtro_produto = data
	Case 'dtini'	
		data = String(uf_null(dw_filtro.GetItemDate(1, name ), Now()), 'yyyy-mm-dd')
		filtro_dtini = data
	Case 'dtfim'	
		data = String(uf_null(dw_filtro.GetItemDate(1, name ), Now()), 'yyyy-mm-dd')
		filtro_dtfim = data	
	Case 'fun_codigo'	
		data = Trim(uf_null(dw_filtro.GetItemString(1, name),''))
		filtro_funcionario = data
End Choose

//If Len(filtro_venda) > 0 Then &
//	ls_filter += "If( Pos(String(fun_codigo), '" + filtro_venda + "') > 0 , 1,0) = 1 and "	
//If Len(filtro_funcionario) > 0 Then &
//	ls_filter += "If( Pos(String(fun_nome), '" + filtro_funcionario + "') > 0 , 1,0) = 1 and "	
//
//ls_filter = Left(ls_filter, Len(ls_filter) - 5)
//
//dw_venda.setFilter( ls_filter )	
//dw_venda.Filter()
end subroutine

public subroutine of_inicializar ();
iw_pai = GetParent().GetParent() 

dw_filtro.of_set_w_pai( iw_pai )
dw_filtro.of_set_color_background( )
dw_filtro.InsertRow(0)

dw_venda.SetTransObject(SQLCA)
dw_produto.SetTransObject(SQLCA)

dw_filtro.SetItem(1, 'dtini', Now())
dw_filtro.SetItem(1, 'dtfim', Now())

filtro_dtini = String(Now(), 'yyyy-mm-dd')
filtro_dtfim = String(Now(), 'yyyy-mm-dd')

of_retrieve()
end subroutine

public subroutine of_retrieve_produto (long row);dw_produto.SetFilter( ' ven_codigo = ' + String(dw_venda.GetItemNumber(row, 'ven_codigo' )) )
dw_produto.Filter()
end subroutine

on uo_pesquisa_venda.create
int iCurrent
call super::create
this.dw_produto=create dw_produto
this.dw_venda=create dw_venda
this.cb_ok=create cb_ok
this.gb_venda=create gb_venda
this.dw_filtro=create dw_filtro
this.gb_filtros=create gb_filtros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_produto
this.Control[iCurrent+2]=this.dw_venda
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.gb_venda
this.Control[iCurrent+5]=this.dw_filtro
this.Control[iCurrent+6]=this.gb_filtros
end on

on uo_pesquisa_venda.destroy
call super::destroy
destroy(this.dw_produto)
destroy(this.dw_venda)
destroy(this.cb_ok)
destroy(this.gb_venda)
destroy(this.dw_filtro)
destroy(this.gb_filtros)
end on

type dw_produto from u_dw within uo_pesquisa_venda
integer x = 27
integer y = 1072
integer width = 3557
integer height = 1140
integer taborder = 30
string dataobject = "d_pesquisa_venda_produto"
boolean ib_selectrow = true
end type

event clicked;call super::clicked;//If dwo.name = 'b_editar' Then of_editar( this.GetItemNumber(row, 'fun_codigo') )
end event

type dw_venda from u_dw within uo_pesquisa_venda
integer x = 27
integer y = 416
integer width = 3557
integer height = 620
integer taborder = 20
string dataobject = "d_pesquisa_venda"
boolean ib_selectrow = true
end type

event clicked;call super::clicked;//If dwo.name = 'b_editar' Then of_editar( this.GetItemNumber(row, 'fun_codigo') )
end event

event rowfocuschanged;call super::rowfocuschanged;of_retrieve_produto( currentrow )
end event

type cb_ok from u_cb within uo_pesquisa_venda
integer x = 3063
integer y = 176
integer taborder = 10
boolean default = true
end type

event clicked;call super::clicked;of_retrieve()
end event

type gb_venda from u_gb within uo_pesquisa_venda
integer y = 344
integer width = 3621
integer height = 1896
integer taborder = 20
integer weight = 700
string text = "Venda"
end type

type dw_filtro from u_dw within uo_pesquisa_venda
integer x = 64
integer y = 60
integer width = 3474
integer height = 228
integer taborder = 10
string dataobject = "d_filtro_venda"
boolean border = false
end type

event editchanged;call super::editchanged;of_filter( row, dwo.name )



end event

event itemchanged;call super::itemchanged;If dwo.name = 'fun_funcao' Then
	this.event editchanged( row , dwo , data )
End if
end event

type gb_filtros from u_gb within uo_pesquisa_venda
integer width = 3621
integer height = 316
integer taborder = 10
integer weight = 700
string text = "Filtros"
end type

