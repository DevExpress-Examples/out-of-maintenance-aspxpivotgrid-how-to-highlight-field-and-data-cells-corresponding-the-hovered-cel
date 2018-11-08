<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="DevExpress.Web.ASPxPivotGrid.v17.2, Version=17.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxPivotGrid" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v17.2, Version=17.2.7.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .hoveredBg {
            background-color: antiquewhite;
        }

        .hoveredBgField {
            background-color: aquamarine;
        }
    </style>
    
    <script type="text/javascript">
      
        function OnInit(s, e) {
            HoverProcessing(s.GetMainElement());
        }
        function OnEndCallback(s, e) {
            HoverProcessing(s.GetMainElement());
        }

        function HoverProcessing(controlHtmlElement) {
            var cellElement = $(controlHtmlElement).find("td[class*='hoverHelper']");
            cellElement.hover(function () { ProcessHoveredCell(this, true); });
            cellElement.mouseout(function () { ProcessHoveredCell(this, false); });
        }

        function ProcessHoveredCell(cell, isHover) {
            var colorAllCells = chColorAll.GetValue();
            var arrayOfClasses = $(cell).attr('class').split(' ');
            var rowClass;
            var colClass;
            for (var i = 0; i < arrayOfClasses.length; i++) {
                if (arrayOfClasses[i].indexOf("hoverHelperRow") >= 0)
                    rowClass = arrayOfClasses[i];
                if (arrayOfClasses[i].indexOf("hoverHelperColumn") >= 0)
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
    </script>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxCheckBox ID="chColorAll" runat="server" Text="Color all corresponding data cells" ClientInstanceName="chColorAll"></dx:ASPxCheckBox>
        <dx:ASPxPivotGrid ID="pivotGrid" runat="server" ClientIDMode="AutoID" DataSourceID="sds"
            OnHtmlCellPrepared="pivotGrid_HtmlCellPrepared" OnHtmlFieldValuePrepared="pivotGrid_HtmlFieldValuePrepared">
            <OptionsView HorizontalScrollBarMode="Auto" />
            <OptionsFilter NativeCheckBoxes="False" />
            <OptionsPager RowsPerPage="50"></OptionsPager>
            <Fields>
                <dx:PivotGridField Area="DataArea" AreaIndex="0" FieldName="ExtendedPrice" ID="fieldExtendedPrice"
                    Caption="Extended Price" />
                <dx:PivotGridField Area="RowArea" AreaIndex="0" FieldName="OrderDate" ID="fieldYear"
                    Caption="Year" GroupInterval="DateYear" UnboundFieldName="fieldOrderDate" />
                <dx:PivotGridField ID="fieldMonth" Area="RowArea" AreaIndex="1" Caption="Month" FieldName="OrderDate"
                    GroupInterval="DateMonth">
                </dx:PivotGridField>
                <dx:PivotGridField Area="ColumnArea" AreaIndex="0" FieldName="ProductName" ID="fieldProductName"
                    Caption="Product Name" />
            </Fields>
            <ClientSideEvents Init="OnInit" EndCallback="OnEndCallback" />
        </dx:ASPxPivotGrid>
        <asp:SqlDataSource ID="sds" runat="server" ConnectionString="<%$ ConnectionStrings:NorthWindConnectionString %>" SelectCommand="SELECT * FROM [Invoices]"></asp:SqlDataSource>
    </form>
</body>
</html>
