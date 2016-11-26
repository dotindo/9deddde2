<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ModelGroup.aspx.cs" Inherits="DotMercy.custom.ModelGroup" %>

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

            <dx:GridViewDataTextColumn Caption="Group Name" FieldName="Name" VisibleIndex="1">
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
        SelectCommand="SELECT [Id], [Name] FROM [ModelGroup]" 
        DeleteCommand="DELETE FROM [ModelGroup] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [ModelGroup] ([Name]) VALUES (@Name)" 
        UpdateCommand="UPDATE [ModelGroup] SET [Name] = @Name WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


</asp:Content>
