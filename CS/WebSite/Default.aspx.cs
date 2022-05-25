using DevExpress.Web.ASPxPivotGrid;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void pivotGrid_HtmlCellPrepared(object sender, DevExpress.Web.ASPxPivotGrid.PivotHtmlCellPreparedEventArgs e)
    {
        e.Cell.CssClass += " hoverHelperRow_" + e.RowIndex;
        e.Cell.CssClass += " hoverHelperColumn_" + e.ColumnIndex;
    }

    protected void pivotGrid_HtmlFieldValuePrepared(object sender, DevExpress.Web.ASPxPivotGrid.PivotHtmlFieldValuePreparedEventArgs e)
    {
        if (e.Field == null)
            return;

        int fieldsCount = pivotGrid.GetFieldCountByArea(e.Field.Area);
        if (e.ValueType == DevExpress.XtraPivotGrid.PivotGridValueType.Value)
            if (e.Field.AreaIndex < fieldsCount - 1)
                return;
        if (e.Field.Area == DevExpress.XtraPivotGrid.PivotArea.RowArea)
            e.Cell.CssClass += " hoverHelperRow_" + e.MinIndex + "_Field";
        if (e.Field.Area == DevExpress.XtraPivotGrid.PivotArea.ColumnArea)
            e.Cell.CssClass += " hoverHelperColumn_" + e.MinIndex + "_Field";
    }

}