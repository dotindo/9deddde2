<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Station.aspx.cs" Inherits="DotMercy.custom.Station" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
	<dx:ASPxGridView ID="masterGrid" runat="server" AutoGenerateColumns="False" DataSourceID="masterDataSource" ClientInstanceName="masterGrid"
		Width="60%" KeyFieldName="Id" CssClass="gridView">
		<Columns>
            <dx:GridViewCommandColumn ShowDeleteButton="true" ShowEditButton="true" ShowNewButtonInHeader="False" VisibleIndex="0">
				<HeaderCaptionTemplate>
					<dx:ASPxHyperLink ID="btnNew" runat="server" Text="New">
						<ClientSideEvents Click="function (s, e) { masterGrid.AddNewRow();}" />
					</dx:ASPxHyperLink>
				</HeaderCaptionTemplate>
			</dx:GridViewCommandColumn>

            <dx:GridViewDataTextColumn FieldName="Id" VisibleIndex="0" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn FieldName="Code" VisibleIndex="1">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Name" FieldName="StationName" VisibleIndex="2">
            </dx:GridViewDataTextColumn>
            
            
		</Columns>

   		<SettingsPager PageSize="32" />
		<Paddings Padding="0px" />
		<Border BorderWidth="0px" />
		<BorderBottom BorderWidth="1px" />
		<Settings ShowGroupPanel="True" />
        <SettingsDetail ShowDetailRow="false" />
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="masterDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [StationName], [Code] FROM [Stations]" 
        DeleteCommand="DELETE FROM [Stations] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [Stations] ([StationName], [Code]) VALUES (@StationName, @Code)" 
        UpdateCommand="UPDATE [Stations] SET [StationName] = @StationName, [Code] = @Code WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="StationName" Type="String" />
            <asp:Parameter Name="Code" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="StationName" Type="String" />
            <asp:Parameter Name="Code" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


</asp:Content>
