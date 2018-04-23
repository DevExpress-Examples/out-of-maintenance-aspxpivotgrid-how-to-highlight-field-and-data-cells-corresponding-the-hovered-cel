Imports DevExpress.Web.ASPxPivotGrid
Imports System
Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls

Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub pivotGrid_HtmlCellPrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxPivotGrid.PivotHtmlCellPreparedEventArgs)
        e.Cell.CssClass &= " hoverHelperRow_" & e.RowIndex
        e.Cell.CssClass &= " hoverHelperColumn_" & e.ColumnIndex
    End Sub

    Protected Sub pivotGrid_HtmlFieldValuePrepared(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxPivotGrid.PivotHtmlFieldValuePreparedEventArgs)
        If e.Field Is Nothing Then
            Return
        End If

        Dim fieldsCount As Integer = pivotGrid.GetFieldCountByArea(e.Field.Area)
        If e.ValueType = DevExpress.XtraPivotGrid.PivotGridValueType.Value Then
            If e.Field.AreaIndex < fieldsCount - 1 Then
                Return
            End If
        End If
        If e.Field.Area = DevExpress.XtraPivotGrid.PivotArea.RowArea Then
            e.Cell.CssClass &= " hoverHelperRow_" & e.MinIndex & "_Field"
        End If
        If e.Field.Area = DevExpress.XtraPivotGrid.PivotArea.ColumnArea Then
            e.Cell.CssClass &= " hoverHelperColumn_" & e.MinIndex & "_Field"
        End If
    End Sub

End Class