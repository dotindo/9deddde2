<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="JobCard.aspx.cs" Inherits="DotMercy.custom.JobCard" %>

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

            <dx:GridViewDataDateColumn Caption="Day" FieldName="Day" VisibleIndex="1">
            </dx:GridViewDataDateColumn>

            <dx:GridViewDataTextColumn Caption="F-DokNo" FieldName="FDokNo" VisibleIndex="2">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="VIN No" FieldName="VInNo" VisibleIndex="3">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Komm-No" FieldName="KommNo" VisibleIndex="4">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Local Prod No" FieldName="LocalProdNo" VisibleIndex="5">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Paint Code" FieldName="PaintCode" VisibleIndex="6">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataTextColumn Caption="Interior Code" FieldName="InteriorCode" VisibleIndex="7">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn Caption="Varian" FieldName="VarianId" VisibleIndex="8">
                <PropertiesComboBox DataSourceID="sdsVarian" TextField="ModelVarian" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn Caption="Engine No" FieldName="EngineNo" VisibleIndex="9">
            </dx:GridViewDataTextColumn>

            <dx:GridViewDataComboBoxColumn Caption="Packing Month" FieldName="PackingMonthId" VisibleIndex="10">
                <PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataTextColumn Caption="Option Codes" FieldName="OptionCodes" VisibleIndex="11">
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
                                            KeyFieldName="Id" Width="70%" OnBeforePerformDataSelect="JobCardGrid_DataSelect">
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                
                                                <dx:GridViewDataSpinEditColumn Caption="Assembly Process No" FieldName="AssemblyProcessNo" VisibleIndex="0">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataTextColumn Caption="Assembly Process Name" FieldName="AssemblyProcessName" VisibleIndex="1">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Assembly Section" FieldName="AssemblySection" VisibleIndex="2">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Assembly Section Name" FieldName="AssemblySectionName" VisibleIndex="3">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Assembly Area" FieldName="AssemblyArea" VisibleIndex="4">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Assembly Area Name" FieldName="AssemblyAreaName" VisibleIndex="5">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataSpinEditColumn Caption="Process No" FieldName="ProcessNo" VisibleIndex="6">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataTextColumn Caption="Process Name" FieldName="ProcessName" VisibleIndex="7">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="Header In Job Card" FieldName="HeaderInJobCard" VisibleIndex="8">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataTextColumn Caption="TextIn Job Card" FieldName="TextInJobCard" VisibleIndex="9">
                                                </dx:GridViewDataTextColumn>

                                                <dx:GridViewDataSpinEditColumn Caption="Sequence" FieldName="Sequence" VisibleIndex="10">
                                                </dx:GridViewDataSpinEditColumn>

                                                <dx:GridViewDataCheckColumn Caption="Show Sequence" FieldName="ShowSequence" VisibleIndex="11">
                                                </dx:GridViewDataCheckColumn>

                                                <dx:GridViewDataCheckColumn Caption="Show Header" FieldName="ShowHeader" VisibleIndex="12">
                                                </dx:GridViewDataCheckColumn>
                                                

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


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT [Id], [Day], [FDokNo], [VInNo], [KommNo], [LocalProdNo], [PaintCode], [InteriorCode], [VarianId], [EngineNo], [PackingMonthId], [OptionCodes] FROM [JobCard]" DeleteCommand="DELETE FROM [JobCard] WHERE [Id] = @Id" InsertCommand="INSERT INTO [JobCard] ([Day], [FDokNo], [VInNo], [KommNo], [LocalProdNo], [PaintCode], [InteriorCode], [VarianId], [EngineNo], [PackingMonthId], [OptionCodes]) VALUES (@Day, @FDokNo, @VInNo, @KommNo, @LocalProdNo, @PaintCode, @InteriorCode, @VarianId, @EngineNo, @PackingMonthId, @OptionCodes)" UpdateCommand="UPDATE [JobCard] SET [Day] = @Day, [FDokNo] = @FDokNo, [VInNo] = @VInNo, [KommNo] = @KommNo, [LocalProdNo] = @LocalProdNo, [PaintCode] = @PaintCode, [InteriorCode] = @InteriorCode, [VarianId] = @VarianId, [EngineNo] = @EngineNo, [PackingMonthId] = @PackingMonthId, [OptionCodes] = @OptionCodes WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Day" DbType="Date" />
            <asp:Parameter Name="FDokNo" Type="String" />
            <asp:Parameter Name="VInNo" Type="String" />
            <asp:Parameter Name="KommNo" Type="String" />
            <asp:Parameter Name="LocalProdNo" Type="String" />
            <asp:Parameter Name="PaintCode" Type="String" />
            <asp:Parameter Name="InteriorCode" Type="String" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="EngineNo" Type="String" />
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="OptionCodes" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Day" DbType="Date" />
            <asp:Parameter Name="FDokNo" Type="String" />
            <asp:Parameter Name="VInNo" Type="String" />
            <asp:Parameter Name="KommNo" Type="String" />
            <asp:Parameter Name="LocalProdNo" Type="String" />
            <asp:Parameter Name="PaintCode" Type="String" />
            <asp:Parameter Name="InteriorCode" Type="String" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="EngineNo" Type="String" />
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="OptionCodes" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [JobCardId], [AssemblyProcessNo], [AssemblyProcessName], [AssemblySection], [AssemblySectionName], [AssemblyArea], [AssemblyAreaName], [ProcessNo], [ProcessName], [HeaderInJobCard], [TextInJobCard], [Sequence], [ShowSequence], [ShowHeader] FROM [JobCardDetail] WHERE ([JobCardId] = @JobCardId)" 
        DeleteCommand="DELETE FROM [JobCardDetail] WHERE [Id] = @original_Id" 
        InsertCommand="INSERT INTO [JobCardDetail] ([JobCardId], [AssemblyProcessNo], [AssemblyProcessName], [AssemblySection], [AssemblySectionName], [AssemblyArea], [AssemblyAreaName], [ProcessNo], [ProcessName], [HeaderInJobCard], [TextInJobCard], [Sequence], [ShowSequence], [ShowHeader]) VALUES (@JobCardId2, @AssemblyProcessNo, @AssemblyProcessName, @AssemblySection, @AssemblySectionName, @AssemblyArea, @AssemblyAreaName, @ProcessNo, @ProcessName, @HeaderInJobCard, @TextInJobCard, @Sequence, @ShowSequence, @ShowHeader)" 
        UpdateCommand="UPDATE [JobCardDetail] SET [JobCardId] = @JobCardId, [AssemblyProcessNo] = @AssemblyProcessNo, [AssemblyProcessName] = @AssemblyProcessName, [AssemblySection] = @AssemblySection, [AssemblySectionName] = @AssemblySectionName, [AssemblyArea] = @AssemblyArea, [AssemblyAreaName] = @AssemblyAreaName, [ProcessNo] = @ProcessNo, [ProcessName] = @ProcessName, [HeaderInJobCard] = @HeaderInJobCard, [TextInJobCard] = @TextInJobCard, [Sequence] = @Sequence, [ShowSequence] = @ShowSequence, [ShowHeader] = @ShowHeader WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="JobCardId2" SessionField="SessionJobCardId2" Type="int32" DefaultValue="0" />
            <asp:Parameter Name="JobCardId" Type="Int32" />
            <asp:Parameter Name="AssemblyProcessNo" Type="Int32" />
            <asp:Parameter Name="AssemblyProcessName" Type="String" />
            <asp:Parameter Name="AssemblySection" Type="String" />
            <asp:Parameter Name="AssemblySectionName" Type="String" />
            <asp:Parameter Name="AssemblyArea" Type="String" />
            <asp:Parameter Name="AssemblyAreaName" Type="String" />
            <asp:Parameter Name="ProcessNo" Type="Int32" />
            <asp:Parameter Name="ProcessName" Type="String" />
            <asp:Parameter Name="HeaderInJobCard" Type="String" />
            <asp:Parameter Name="TextInJobCard" Type="String" />
            <asp:Parameter Name="Sequence" Type="Int32" />
            <asp:Parameter Name="ShowSequence" Type="Boolean" />
            <asp:Parameter Name="ShowHeader" Type="Boolean" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="JobCardId" SessionField="SessionJobCardId" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="JobCardId" Type="Int32" />
            <asp:Parameter Name="AssemblyProcessNo" Type="Int32" />
            <asp:Parameter Name="AssemblyProcessName" Type="String" />
            <asp:Parameter Name="AssemblySection" Type="String" />
            <asp:Parameter Name="AssemblySectionName" Type="String" />
            <asp:Parameter Name="AssemblyArea" Type="String" />
            <asp:Parameter Name="AssemblyAreaName" Type="String" />
            <asp:Parameter Name="ProcessNo" Type="Int32" />
            <asp:Parameter Name="ProcessName" Type="String" />
            <asp:Parameter Name="HeaderInJobCard" Type="String" />
            <asp:Parameter Name="TextInJobCard" Type="String" />
            <asp:Parameter Name="Sequence" Type="Int32" />
            <asp:Parameter Name="ShowSequence" Type="Boolean" />
            <asp:Parameter Name="ShowHeader" Type="Boolean" />
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
