<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ProductionSequence.aspx.cs" Inherits="DotMercy.custom.ProductionSequence" %>

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

            <dx:GridViewDataComboBoxColumn Caption="Packing Month" FieldName="PackingMonth" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Model" FieldName="ModelId" VisibleIndex="2">
                <PropertiesComboBox DataSourceID="sdsModel" TextField="VarianName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Varian" FieldName="VarianId" VisibleIndex="3">
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
                                            KeyFieldName="Id" Width="70%" OnBeforePerformDataSelect="ProdSeqGrid_DataSelect">
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                
                                                <dx:GridViewDataSpinEditColumn Caption="Type" FieldName="Type" VisibleIndex="0">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataSpinEditColumn Caption="Cumm Figr" FieldName="CummFigr" VisibleIndex="1">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataTextColumn Caption="Material No" FieldName="MaterialNo" VisibleIndex="2">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Order No" FieldName="OrderNo" VisibleIndex="3">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Serial Number" FieldName="SerialNumber" VisibleIndex="4">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="DB Prod SIFI" FieldName="DBProdSIFI" VisibleIndex="5">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Comnos Number" FieldName="ComnosNumber" VisibleIndex="6">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataSpinEditColumn Caption="Lot" FieldName="Lot" VisibleIndex="7">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataTextColumn Caption="Engnine No" FieldName="EngnineNo" VisibleIndex="8">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataSpinEditColumn Caption="Col Code" FieldName="ColCode" VisibleIndex="9">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataSpinEditColumn Caption="Int Code" FieldName="IntCode" VisibleIndex="10">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataTextColumn Caption="Bom Expl" FieldName="BomExpl" VisibleIndex="11">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Chassis No DCAG" FieldName="ChassisNoDCAG" VisibleIndex="12">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Finish Date" FieldName="FinishDate" VisibleIndex="13">
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


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT [Id], [PackingMonth], [ModelId], [VarianId], [FileType] FROM [ProductionSequence]" DeleteCommand="DELETE FROM [ProductionSequence] WHERE [Id] = @Id" InsertCommand="INSERT INTO [ProductionSequence] ([PackingMonth], [ModelId], [VarianId], [FileType]) VALUES (@PackingMonth, @ModelId, @VarianId, @FileType)" UpdateCommand="UPDATE [ProductionSequence] SET [PackingMonth] = @PackingMonth, [ModelId] = @ModelId, [VarianId] = @VarianId, [FileType] = @FileType WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PackingMonth" Type="Int32" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="FileType" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PackingMonth" Type="Int32" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="FileType" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [ProductionSequenceId], [Type], [CummFigr], [MaterialNo], [OrderNo], [SerialNumber], [DBProdSIFI], [ComnosNumber], [Lot], [EngnineNo], [ColCode], [IntCode], [BomExpl], [ChassisNoDCAG], [FinishDate] FROM [ProductionSequenceDetail] WHERE ([ProductionSequenceId] = @ProductionSequenceId)" 
        DeleteCommand="DELETE FROM [ProductionSequenceDetail] WHERE [Id] = @original_Id" 
        InsertCommand="INSERT INTO [ProductionSequenceDetail] ([ProductionSequenceId], [Type], [CummFigr], [MaterialNo], [OrderNo], [SerialNumber], [DBProdSIFI], [ComnosNumber], [Lot], [EngnineNo], [ColCode], [IntCode], [BomExpl], [ChassisNoDCAG], [FinishDate]) VALUES (@ProductionSequenceId, @Type, @CummFigr, @MaterialNo, @OrderNo, @SerialNumber, @DBProdSIFI, @ComnosNumber, @Lot, @EngnineNo, @ColCode, @IntCode, @BomExpl, @ChassisNoDCAG, @FinishDate)" 
        UpdateCommand="UPDATE [ProductionSequenceDetail] SET [ProductionSequenceId] = @ProductionSequenceId, [Type] = @Type, [CummFigr] = @CummFigr, [MaterialNo] = @MaterialNo, [OrderNo] = @OrderNo, [SerialNumber] = @SerialNumber, [DBProdSIFI] = @DBProdSIFI, [ComnosNumber] = @ComnosNumber, [Lot] = @Lot, [EngnineNo] = @EngnineNo, [ColCode] = @ColCode, [IntCode] = @IntCode, [BomExpl] = @BomExpl, [ChassisNoDCAG] = @ChassisNoDCAG, [FinishDate] = @FinishDate WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ProductionSequenceId" Type="Int32" />
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="CummFigr" Type="Int32" />
            <asp:Parameter Name="MaterialNo" Type="String" />
            <asp:Parameter Name="OrderNo" Type="String" />
            <asp:Parameter Name="SerialNumber" Type="String" />
            <asp:Parameter Name="DBProdSIFI" Type="String" />
            <asp:Parameter Name="ComnosNumber" Type="String" />
            <asp:Parameter Name="Lot" Type="Int32" />
            <asp:Parameter Name="EngnineNo" Type="String" />
            <asp:Parameter Name="ColCode" Type="Int32" />
            <asp:Parameter Name="IntCode" Type="Int32" />
            <asp:Parameter Name="BomExpl" Type="String" />
            <asp:Parameter Name="ChassisNoDCAG" Type="String" />
            <asp:Parameter Name="FinishDate" Type="String" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="ProductionSequenceId" SessionField="SessionProdSquenceId" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ProductionSequenceId" Type="Int32" />
            <asp:Parameter Name="Type" Type="String" />
            <asp:Parameter Name="CummFigr" Type="Int32" />
            <asp:Parameter Name="MaterialNo" Type="String" />
            <asp:Parameter Name="OrderNo" Type="String" />
            <asp:Parameter Name="SerialNumber" Type="String" />
            <asp:Parameter Name="DBProdSIFI" Type="String" />
            <asp:Parameter Name="ComnosNumber" Type="String" />
            <asp:Parameter Name="Lot" Type="Int32" />
            <asp:Parameter Name="EngnineNo" Type="String" />
            <asp:Parameter Name="ColCode" Type="Int32" />
            <asp:Parameter Name="IntCode" Type="Int32" />
            <asp:Parameter Name="BomExpl" Type="String" />
            <asp:Parameter Name="ChassisNoDCAG" Type="String" />
            <asp:Parameter Name="FinishDate" Type="String" />
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
