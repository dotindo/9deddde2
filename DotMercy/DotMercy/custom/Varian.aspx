<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="Varian.aspx.cs" Inherits="DotMercy.custom.Varian" %>

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

            <dx:GridViewDataComboBoxColumn Caption="Type" FieldName="ModelTypeId" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="sdsModelTypes" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Group" FieldName="TypeId" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="sdsModelGroup" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn Caption="Code" FieldName="VarianCode" VisibleIndex="3">
                <EditFormSettings Visible="true" />
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Model Name" FieldName="VarianName" VisibleIndex="4">
                <EditFormSettings Visible="true" />
            </dx:GridViewDataTextColumn>

            

            
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
                                            KeyFieldName="Id" Width="100%" OnBeforePerformDataSelect="VarianGrid_DataSelect">
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="1" />
                                                
                                                <dx:GridViewDataTextColumn Caption="Varian" FieldName="ModelVarian" VisibleIndex="1">
                                                    <EditFormSettings Visible="true" />
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


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT [Id], [VarianCode], [VarianName], [ModelTypeId], [TypeId] FROM [Varians]" DeleteCommand="DELETE FROM [Varians] WHERE [Id] = @Id" InsertCommand="INSERT INTO [Varians] ([VarianCode], [VarianName], [ModelTypeId], [TypeId]) VALUES (@VarianCode, @VarianName, @ModelTypeId, @TypeId)" UpdateCommand="UPDATE [Varians] SET [VarianCode] = @VarianCode, [VarianName] = @VarianName, [ModelTypeId] = @ModelTypeId, [TypeId] = @TypeId WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="VarianCode" Type="String" />
            <asp:Parameter Name="VarianName" Type="String" />
            <asp:Parameter Name="ModelTypeId" Type="Int32" />
            <asp:Parameter Name="TypeId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="VarianCode" Type="String" />
            <asp:Parameter Name="VarianName" Type="String" />
            <asp:Parameter Name="ModelTypeId" Type="Int32" />
            <asp:Parameter Name="TypeId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [VarianId], [ModelVarian], [TypeId] FROM [VarianDetails] WHERE ([VarianId] = @VarianId)" 
        DeleteCommand="DELETE FROM [VarianDetails] WHERE [Id] = @original_Id" 
        InsertCommand="INSERT INTO [VarianDetails] ([VarianId], [ModelVarian], [TypeId]) VALUES (@VarianId2, @ModelVarian, @TypeId)" 
        UpdateCommand="UPDATE [VarianDetails] SET [ModelVarian] = @ModelVarian, [TypeId] = @TypeId WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="VarianId2" SessionField="SessionId2" Type="int32" DefaultValue="0" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="ModelVarian" Type="String" />
            <asp:Parameter Name="TypeId" Type="Int32" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="VarianId" SessionField="SessionId" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="ModelVarian" Type="String" />
            <asp:Parameter Name="TypeId" Type="Int32" />
            <asp:Parameter Name="original_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
    <asp:SqlDataSource ID="sdsModelTypes" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, Name from ModelTypes Order by Name">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModelGroup" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, Name from ModelGroup Order by Name">                   
    </asp:SqlDataSource>

</asp:Content>
