<!-- default badges list -->
[![](https://img.shields.io/badge/Open_in_DevExpress_Support_Center-FF7200?style=flat-square&logo=DevExpress&logoColor=white)](https://supportcenter.devexpress.com/ticket/details/T621056)
[![](https://img.shields.io/badge/📖_How_to_use_DevExpress_Examples-e9f6fc?style=flat-square)](https://docs.devexpress.com/GeneralInformation/403183)
<!-- default badges end -->
# Pivot Grid for Web Forms - How to Highlight Field and Data Cells that Correspond to the Hovered Cell

<!-- run online -->
**[[Run Online]](https://codecentral.devexpress.com/t621056/)**
<!-- run online end -->
This example illustrates how to highlight field and data cells that correspond to the hovered cell.


![Pivot Grid for Web Forms - Hightlighting data cells](media/7c770969-ded8-4eaa-9ec8-f052f7dd136a.png)

Ckick on the checkbox to highlight the corresponding cells:

![Pivot Grid for Web Forms - Hightlighting all corresponding data cells](media/7d663a5d-2701-411f-88ca-3d07da9f1eda.png)

## Overview

You cannot highlight cells that correspond to the hovered cell in [ASPxPivotGrid](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxPivotGrid.ASPxPivotGrid) out of the box. The example shows how to use  [jQuery](https://jquery.com/) to implement this functionality.




1. Handle the [`ASPxPivotGrid.HtmlCellPrepared`](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxPivotGrid.ASPxPivotGrid.HtmlCellPrepared) event to add CSS classes that contain rows and column indexes to data cells:
```csharp
protected void pivotGrid_HtmlCellPrepared(object sender, DevExpress.Web.ASPxPivotGrid.PivotHtmlCellPreparedEventArgs e)
{
    e.Cell.CssClass += " hoverHelperRow_" + e.RowIndex;
    e.Cell.CssClass += " hoverHelperColumn_" + e.ColumnIndex;
}
```
2. Handle the [`ASPxPivotGrid.HtmlFieldValuePrepared`](https://docs.devexpress.com/AspNet/DevExpress.Web.ASPxPivotGrid.ASPxPivotGrid.HtmlFieldValuePrepared) event to add similar CSS classes to field cells:
```csharp
protected void pivotGrid_HtmlFieldValuePrepared(object sender, DevExpress.Web.ASPxPivotGrid.PivotHtmlFieldValuePreparedEventArgs e)
{
    if (e.Field == null)
        return;
     int fieldsCount = pivotGrid.GetFieldCountByArea(e.Field.Area);
    if (e.ValueType == DevExpress.XtraPivotGrid.PivotGridValueType.Value)
        if (e.Field.AreaIndex &lt; fieldsCount - 1)
            return;
    if (e.Field.Area == DevExpress.XtraPivotGrid.PivotArea.RowArea)
        e.Cell.CssClass += " hoverHelperRow_" + e.MinIndex + "_Field";
    if (e.Field.Area == DevExpress.XtraPivotGrid.PivotArea.ColumnArea)
        e.Cell.CssClass += " hoverHelperColumn_" + e.MinIndex + "_Field";
}
```
3. Handle the client-side [`Init`](https://docs.devexpress.com/AspNet/js-ASPxClientControlBase.Init) and [`EndCallback`](https://docs.devexpress.com/AspNet/js-ASPxClientPivotGrid.EndCallback) events for the Pivot Grid:
```js
function OnInit(s, e) {
    HoverProcessing(s.GetMainElement());
}
function OnEndCallback(s, e) {
    HoverProcessing(s.GetMainElement());
}
```
4. The **HoverProcessing** function determines the hovered cell's column and row index and applies the corresponding CSS class to the required data and field cells (see [Default.aspx](./CS/WebSite/Default.aspx#L31-L69)).

## Files to Look At
* [Default.aspx](./CS/WebSite/Default.aspx) (VB: [Default.aspx](./VB/WebSite/Default.aspx))
* [Default.aspx.cs](./CS/WebSite/Default.aspx.cs) (VB: [Default.aspx.vb](./VB/WebSite/Default.aspx.vb))
