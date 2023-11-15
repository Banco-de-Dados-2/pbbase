HA$PBExportHeader$nv_produto.sru
forward
global type nv_produto from nonvisualobject
end type
end forward

global type nv_produto from nonvisualobject
end type
global nv_produto nv_produto

forward prototypes
public function decimal of_get_preco (long al_codigo)
public function decimal of_get_qtd (long al_codigo)
end prototypes

public function decimal of_get_preco (long al_codigo);Decimal lde_retorno

SELECT
    PRO_VALOR
INTO
    :lde_retorno
FROM
    DBA.TB_PRODUTO
WHERE
    pro_codigo = :al_codigo
USING SQLCA;

return uf_null(lde_retorno, 0)
end function

public function decimal of_get_qtd (long al_codigo);Decimal lde_retorno

SELECT
    PRO_QUANTIDADE
INTO
    :lde_retorno
FROM
    DBA.TB_PRODUTO
WHERE
    pro_codigo = :al_codigo
USING SQLCA;

return uf_null(lde_retorno, 0)
end function

on nv_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nv_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

