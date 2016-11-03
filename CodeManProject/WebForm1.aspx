<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="CodeManProject.WebForm1" %>
<%@ Register Src="~/Dock/Common/TelerikNewsCS.ascx" TagName="News" TagPrefix="uc2" %>
<%@ Register Src="~/Dock/Common/TelerikBlogsCS.ascx" TagName="Blogs" TagPrefix="uc2" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <div class="demo-container size-wide">
        <telerik:RadDockLayout runat="server" ID="RadDockLayout1">
            <table>
                <tr>
                    <td style="vertical-align: top">
                        <telerik:RadDockZone ID="RadDockZone2" runat="server" Orientation="Vertical" Width="450px"
                                             MinHeight="400px">
                            <telerik:RadDock RenderMode="Lightweight" ID="RadDock1" runat="server" Title="Blogs" Width="450px" EnableAnimation="true"
                                             EnableRoundedCorners="true" Resizable="true" CssClass="higherZIndex">
                                <ContentTemplate>
                                    <telerik:RadScheduler ID="RadScheduler1" runat="server"></telerik:RadScheduler>
                                </ContentTemplate>
                            </telerik:RadDock>
                        </telerik:RadDockZone>
                    </td>
                    <td style="vertical-align: top">
                        <telerik:RadDockZone ID="RadDockZone1" runat="server" Orientation="Vertical" Width="350px"
                                             MinHeight="400px">
                            <telerik:RadDock RenderMode="Lightweight" ID="RadDock2" runat="server" Title="News" Width="350px" EnableAnimation="true"
                                             EnableRoundedCorners="true" Resizable="true" CssClass="higherZIndex">
                                <ContentTemplate>
                                    <telerik:RadAjaxLoadingPanel runat="server" ID="RadAjaxLoadingPanel1"></telerik:RadAjaxLoadingPanel>
  <div class="demo-container">
    <div class="filterDiv">
      <telerik:RadFilter RenderMode="Lightweight" runat="server" ID="RadFilter1" FilterContainerID="RadGrid1" ShowApplyButton="false"></telerik:RadFilter>
    </div>
    <telerik:RadGrid RenderMode="Lightweight" runat="server" ID="RadGrid1" AutoGenerateColumns="false" DataSourceID="SqlDataSource1" AllowPaging="true" AllowSorting="true" AllowFilteringByColumn="true" OnItemCommand="RadGrid1_ItemCommand">
      <MasterTableView IsFilterItemExpanded="false" CommandItemDisplay="Top">
        <CommandItemTemplate>
          <telerik:RadToolBar RenderMode="Lightweight" runat="server" ID="RadToolBar1" AutoPostBack="true">
            <Items>
              <telerik:RadToolBarButton Text="Apply filter" CommandName="FilterRadGrid" 
                  ImageUrl="<%#GetFilterIcon() %>" ImagePosition="Right"></telerik:RadToolBarButton>
            </Items>
          </telerik:RadToolBar>
        </CommandItemTemplate>
        <Columns>
          <telerik:GridNumericColumn DataField="OrderID" HeaderText="OrderID" DataType="System.Int32"></telerik:GridNumericColumn>
          <telerik:GridDateTimeColumn DataField="OrderDate" HeaderText="OrderDate" DataFormatString="{0:MM/dd/yyyy}"></telerik:GridDateTimeColumn>
          <telerik:GridNumericColumn DataField="ShipVia" HeaderText="ShipVia" DataType="System.Int32"></telerik:GridNumericColumn>
          <telerik:GridBoundColumn DataField="ShipName" HeaderText="ShipName"></telerik:GridBoundColumn>
          <telerik:GridBoundColumn DataField="ShipAddress" HeaderText="ShipAddress"></telerik:GridBoundColumn>
          <telerik:GridNumericColumn DataField="Freight" HeaderText="Freight" DataType="System.Decimal"></telerik:GridNumericColumn>
        </Columns>
      </MasterTableView>
    </telerik:RadGrid>
  </div>
  <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:NorthwindConnectionString %>" SelectCommand="Select OrderID, OrderDate, ShipVia, ShipName, ShipAddress, Freight FROM Orders"></asp:SqlDataSource>
                                </ContentTemplate>
                            </telerik:RadDock>
                        </telerik:RadDockZone>
                    </td>
                </tr>
            </table>
            <br />
 
        </telerik:RadDockLayout>
    </div>
 
    </form>
</body>
</html>
