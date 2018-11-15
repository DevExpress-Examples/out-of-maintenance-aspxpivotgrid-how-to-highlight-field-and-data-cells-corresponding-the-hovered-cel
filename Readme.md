<!-- default file list -->
*Files to look at*:

* [Default.aspx](./CS/Default.aspx) (VB: [Default.aspx](./VB/Default.aspx))
* [Default.aspx.cs](./CS/Default.aspx.cs) (VB: [Default.aspx](./VB/Default.aspx))
<!-- default file list end -->
# ASPxPivotGrid - How to highlight field and data cells corresponding the hovered cell


<p>ASPxPivotGrid - How to highlight field and data cells corresponding the hovered cell<br><br>This example illustrates how to highlight field and data cells corresponding to the hovered cell:<br><img src="https://raw.githubusercontent.com/DevExpress-Examples/aspxpivotgrid-how-to-highlight-field-and-data-cells-corresponding-the-hovered-cell-t621056/17.2.7+/media/7c770969-ded8-4eaa-9ec8-f052f7dd136a.png"> <br><img src="https://raw.githubusercontent.com/DevExpress-Examples/aspxpivotgrid-how-to-highlight-field-and-data-cells-corresponding-the-hovered-cell-t621056/17.2.7+/media/7d663a5d-2701-411f-88ca-3d07da9f1eda.png"><br>Since ASPxPivotGrid does not support this scenario out of the box, the only possible way is implementing this task using jQuery. </p>


<h3>Description</h3>

<p>To implement this approach, perform the following steps:<br>Handle the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxPivotGridASPxPivotGrid_HtmlCellPreparedtopic">ASPxPivotGrid.HtmlCellPrepared</a>&nbsp;event to add CSS classes that contain rows and column indexes to data cells:</p>
<code lang="cs">protected void pivotGrid_HtmlCellPrepared(object sender, DevExpress.Web.ASPxPivotGrid.PivotHtmlCellPreparedEventArgs e)
{
    e.Cell.CssClass += " hoverHelperRow_" + e.RowIndex;
    e.Cell.CssClass += " hoverHelperColumn_" + e.ColumnIndex;
}
</code>
<p>&nbsp;Then, handle the&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxPivotGridASPxPivotGrid_HtmlFieldValuePreparedtopic">ASPxPivotGrid.HtmlFieldValuePrepared</a>&nbsp;event to add similar classes to field cells:</p>
<code lang="cs">protected void pivotGrid_HtmlFieldValuePrepared(object sender, DevExpress.Web.ASPxPivotGrid.PivotHtmlFieldValuePreparedEventArgs e)
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
</code>
<p>&nbsp;Handle the client-side&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebScriptsASPxClientControlBase_Inittopic">Init</a>&nbsp;and&nbsp;<a href="https://documentation.devexpress.com/#AspNet/DevExpressWebASPxPivotGridScriptsASPxClientPivotGrid_EndCallbacktopic">EndCallback</a>&nbsp;for your pivot grid:</p>
<code lang="js">function OnInit(s, e) {
    HoverProcessing(s.GetMainElement());
}
function OnEndCallback(s, e) {
    HoverProcessing(s.GetMainElement());
}
</code>
<p>&nbsp;The&nbsp;<strong>HoverProcessing</strong> function will determine the hovered cell column and row index and apply the corresponding CSS class to the required data and field cells:</p>
<code lang="js">function HoverProcessing(controlHtmlElement) {
	var cellElement = $(controlHtmlElement).find("td[class*='hoverHelper']");
	cellElement.hover(function () { ProcessHoveredCell(this, true); });
	cellElement.mouseout(function () { ProcessHoveredCell(this, false); });
}
 function ProcessHoveredCell(cell, isHover) {
	var colorAllCells = chColorAll.GetValue();
	var arrayOfClasses = $(cell).attr('class').split(' ');
	var rowClass;
	var colClass;
	for (var i = 0; i &lt; arrayOfClasses.length; i++) {
		if (arrayOfClasses[i].indexOf("hoverHelperRow") &gt;= 0)
			rowClass = arrayOfClasses[i];
		if (arrayOfClasses[i].indexOf("hoverHelperColumn") &gt;= 0)
			colClass = arrayOfClasses[i];
	}
 	if (isHover) {
		if (colorAllCells) {
			$("." + rowClass).addClass("hoveredBg");
			$("." + colClass).addClass("hoveredBg");
		}
		else
			$(cell).addClass("hoveredBg");
		$("." + rowClass + "_Field").addClass("hoveredBgField");
		$("." + colClass + "_Field").addClass("hoveredBgField");
	}
	else {
		if (colorAllCells) {
			$("." + rowClass).removeClass("hoveredBg");
			$("." + colClass).removeClass("hoveredBg");
		}
		else
			$(cell).removeClass("hoveredBg");
		$("." + rowClass + "_Field").removeClass("hoveredBgField");
		$("." + colClass + "_Field").removeClass("hoveredBgField");
	}
}
</code>
<p>&nbsp;</p>

<br/>


