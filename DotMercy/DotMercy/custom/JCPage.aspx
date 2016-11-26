<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="JCPage.aspx.cs" Inherits="DotMercy.custom.JCPage" %>

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

            <dx:GridViewDataTextColumn Caption="JC Page No" FieldName="JCPageNo" VisibleIndex="1">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Description" FieldName="Description" VisibleIndex="2">
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
        SelectCommand="SELECT [Id], [JCPageNo], [Description] FROM [JCPage]" 
        DeleteCommand="DELETE FROM [JCPage] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [JCPage] ([JCPageNo], [Description]) VALUES (@JCPageNo, @Description)" 
        UpdateCommand="UPDATE [JCPage] SET [JCPageNo] = @JCPageNo, [Description] = @Description WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>            
            <asp:Parameter Name="JCPageNo" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            
            <asp:Parameter Name="JCPageNo" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


</asp:Content>
