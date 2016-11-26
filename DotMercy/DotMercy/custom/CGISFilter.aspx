<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CGISFilter.aspx.cs" Inherits="DotMercy.custom.CGISFilter" %>

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

            <dx:GridViewDataComboBoxColumn FieldName="AssemblySectionId" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="sdsAssemblySections" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn FieldName="StationId" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="sdsStation" TextField="StationName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn Caption="Process Number From" FieldName="ProcessNumberfrom" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Process Number To" FieldName="ProcessNumberto" VisibleIndex="4">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Exception" FieldName="Exception" VisibleIndex="5">
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
        SelectCommand="SELECT [Id], [AssemblySectionId], [StationId], [ProcessNumberfrom], [ProcessNumberto], [Exception] FROM [CGISFilter]" 
        DeleteCommand="DELETE FROM [CGISFilter] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [CGISFilter] ([AssemblySectionId], [StationId], [ProcessNumberfrom], [ProcessNumberto], [Exception]) VALUES (@AssemblySectionId, @StationId, @ProcessNumberfrom, @ProcessNumberto, @Exception)" 
        UpdateCommand="UPDATE [CGISFilter] SET [AssemblySectionId] = @AssemblySectionId, [StationId] = @StationId, [ProcessNumberfrom] = @ProcessNumberfrom, [ProcessNumberto] = @ProcessNumberto, [Exception] = @Exception WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="AssemblySectionId" Type="Int32" />
            <asp:Parameter Name="StationId" Type="Int32" />
            <asp:Parameter Name="ProcessNumberfrom" Type="String" />
            <asp:Parameter Name="ProcessNumberto" Type="String" />
            <asp:Parameter Name="Exception" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="AssemblySectionId" Type="Int32" />
            <asp:Parameter Name="StationId" Type="Int32" />
            <asp:Parameter Name="ProcessNumberfrom" Type="String" />
            <asp:Parameter Name="ProcessNumberto" Type="String" />
            <asp:Parameter Name="Exception" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsStation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, Code, StationName from Stations Order by StationName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsAssemblySections" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, Code, Name from AssemblySections Order by Name">                   
    </asp:SqlDataSource>

</asp:Content>
