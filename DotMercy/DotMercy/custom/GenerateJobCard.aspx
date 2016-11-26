<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="GenerateJobCard.aspx.cs" Inherits="DotMercy.custom.GenerateJobCard" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <style type="text/css">
        .categoryTable
        {
            width: 100%;
        }
        .categoryTable .imageCell
        {
            padding: 2px;
        }
        .categoryTable .textCell
        {
            padding-left: 20px;
            width: 100%;
        }
        .textCell .label
        {
            color: #969696;
        }
        .textCell .description
        {
            font-size: 13px;
            width: 230px;
        }
    </style>

    <dx:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server" DataSourceID="SqlDataSource1"
        KeyFieldName="Id" Width="100%" AutoGenerateColumns="False">
        <Columns>
            <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />

            <dx:GridViewDataDateColumn Caption="Date" FieldName="Date" VisibleIndex="1">
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataComboBoxColumn Caption="Packing Month" FieldName="PackingMonthId" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Group" FieldName="GroupId" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="sdsModelGroup" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Model" FieldName="ModelId" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="sdsModel" TextField="VarianName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Varian" FieldName="VarianId" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="sdsVarian" TextField="ModelVarian" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn Caption="Start Prod No" FieldName="StartProdNo" VisibleIndex="6">
                <EditFormSettings Visible="true" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="End Prod No" FieldName="EndProdNo" VisibleIndex="7">
                <EditFormSettings Visible="true" />
            </dx:GridViewDataTextColumn>
                        
            
        </Columns>

        <Settings ShowGroupPanel="True" />

        <SettingsDetail ShowDetailRow="false" />
        <SettingsBehavior EnableCustomizationWindow="true" />
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT [Id], [Date], [VarianId], [PackingMonthId], [GroupId], [StartProdNo], [EndProdNo], [ModelId] FROM [GenerateJobCard]" DeleteCommand="DELETE FROM [GenerateJobCard] WHERE [Id] = @Id" InsertCommand="INSERT INTO [GenerateJobCard] ([Date], [VarianId], [PackingMonthId], [GroupId], [StartProdNo], [EndProdNo], [ModelId]) VALUES (@Date, @VarianId, @PackingMonthId, @GroupId, @StartProdNo, @EndProdNo, @ModelId)" UpdateCommand="UPDATE [GenerateJobCard] SET [Date] = @Date, [VarianId] = @VarianId, [PackingMonthId] = @PackingMonthId, [GroupId] = @GroupId, [StartProdNo] = @StartProdNo, [EndProdNo] = @EndProdNo, [ModelId] = @ModelId WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Date" DbType="Date" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="GroupId" Type="Int32" />
            <asp:Parameter Name="StartProdNo" Type="String" />
            <asp:Parameter Name="EndProdNo" Type="String" />
            <asp:Parameter Name="ModelId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Date" DbType="Date" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="GroupId" Type="Int32" />
            <asp:Parameter Name="StartProdNo" Type="String" />
            <asp:Parameter Name="EndProdNo" Type="String" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPackingMonth" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, PackingMth from PackingMonths Order by PackingMth">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModel" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, VarianName from Varians Order by VarianName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModelGroup" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, Name from ModelGroup Order by Name">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsVarian" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, ModelVarian from VarianDetails Order by ModelVarian">                   
    </asp:SqlDataSource>

</asp:Content>
