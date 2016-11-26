<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="JobCardPc.aspx.cs" Inherits="DotMercy.custom.JobCardPc" %>

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

            <dx:GridViewDataTextColumn FieldName="Id" ReadOnly="True" VisibleIndex="0">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn Caption="Packing Month" FieldName="PackingMonthId" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Group" FieldName="Group" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="sdsModelTypes" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Model" FieldName="ModelId" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="sdsModel" TextField="VarianName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Varian" FieldName="VarianId" VisibleIndex="4">
                <PropertiesComboBox DataSourceID="sdsVarian" TextField="ModelVarian" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

        </Columns>

        <Templates>
            <DetailRow>
                <div style="padding: 3px 3px 2px 3px">
                    <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" EnableCallBacks="true">
                        <TabPages>
                            <dx:TabPage Text="Detail" Visible="true">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                        <dx:ASPxGridView ID="productsGrid" runat="server" DataSourceID="SqlDataSource2"
                                            KeyFieldName="Id" Width="100%" OnBeforePerformDataSelect="JobCardGrid_DataSelect">
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="1" />
                                                
                                                <dx:GridViewDataComboBoxColumn Caption="Assembly Section" FieldName="AssemblySectionId" VisibleIndex="1">
                                                    <PropertiesComboBox DataSourceID="sdsAssemblySection" TextField="Name" ValueField="Id"></PropertiesComboBox>
                                                </dx:GridViewDataComboBoxColumn>

                                                <dx:GridViewDataTextColumn Caption="JC Page Description" FieldName="JCPageDesc" VisibleIndex="2">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Print Sequence" FieldName="PrintSequence" VisibleIndex="3">
                                                </dx:GridViewDataTextColumn>

                                            </Columns>

                                            <SettingsDetail ShowDetailRow="false" />
                                            <Settings ShowFooter="True" />
                                        </dx:ASPxGridView>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            
                            
                        </TabPages>
                    </dx:ASPxPageControl>
                </div>
            </DetailRow>
        </Templates>

        <Settings ShowGroupPanel="True" />

        <SettingsDetail ShowDetailRow="true" />
        <SettingsBehavior EnableCustomizationWindow="true" />
    </dx:ASPxGridView>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT [Id], [PackingMonthId], [Group], [ModelId], [VarianId] FROM [JobCardPc]" DeleteCommand="DELETE FROM [JobCardPc] WHERE [Id] = @Id" InsertCommand="INSERT INTO [JobCardPc] ([PackingMonthId], [Group], [ModelId], [VarianId]) VALUES (@PackingMonthId, @Group, @ModelId, @VarianId)" UpdateCommand="UPDATE [JobCardPc] SET [PackingMonthId] = @PackingMonthId, [Group] = @Group, [ModelId] = @ModelId, [VarianId] = @VarianId WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="Group" Type="Int32" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="Group" Type="Int32" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [JobCardPcId], [AssemblySectionId], [JCPageDesc], [PrintSequence] FROM [JobCardPcDetail] WHERE ([JobCardPcId] = @JobCardPcId)" 
        DeleteCommand="DELETE FROM [JobCardPcDetail] WHERE [Id] = @original_Id" 
        InsertCommand="INSERT INTO [JobCardPcDetail] ([JobCardPcId], [AssemblySectionId], [JCPageDesc], [PrintSequence]) VALUES (@JobCardPcId2, @AssemblySectionId, @JCPageDesc, @PrintSequence)" 
        UpdateCommand="UPDATE [JobCardPcDetail] SET [AssemblySectionId] = @AssemblySectionId, [JCPageDesc] = @JCPageDesc, [PrintSequence] = @PrintSequence WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="JobCardPcId2" SessionField="SessionJobCardPcId2" Type="int32" DefaultValue="0" />
            <asp:Parameter Name="JobCardPcId" Type="Int32" />
            <asp:Parameter Name="AssemblySectionId" Type="Int32" />
            <asp:Parameter Name="JCPageDesc" Type="Int32" />
            <asp:Parameter Name="PrintSequence" Type="Int32" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="JobCardPcId" SessionField="SessionJobCardPcId" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="JobCardPcId" Type="Int32" />
            <asp:Parameter Name="AssemblySectionId" Type="Int32" />
            <asp:Parameter Name="JCPageDesc" Type="Int32" />
            <asp:Parameter Name="PrintSequence" Type="Int32" />
            <asp:Parameter Name="original_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsPackingMonth" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, PackingMth from PackingMonths Order by PackingMth">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModelTypes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, Name from ModelTypes Order by Name">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModel" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, VarianCode, VarianName, ModelTypeId, TypeId from Varians Order by VarianName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsVarian" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, VarianId, ModelVarian, TypeId from VarianDetails Order by ModelVarian">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsAssemblySection" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, Code, Name from AssemblySections Order by Name">                   
    </asp:SqlDataSource>

</asp:Content>
