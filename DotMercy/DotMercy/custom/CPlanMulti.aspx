<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="CPlanMulti.aspx.cs" Inherits="DotMercy.custom.CPlanMulti" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <script type="text/javascript">
        function UploadBtnClick() {
            document.getElementById("hiddenField").value = uploader.GetText();
            uploader.UploadFile();
        }

        function UploadBtnClick2() {
            document.getElementById("hiddenField2").value = uploader2.GetText();
            uploader2.UploadFile();
        }
    </script>

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

            <dx:GridViewDataComboBoxColumn Caption="Packing Month" FieldName="PackingMonthId"
                VisibleIndex="1" PropertiesComboBox-DataSourceID="sdsPackingMonth"
                PropertiesComboBox-TextField="PackingMth" PropertiesComboBox-ValueField="Id" >
<PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Model" FieldName="ModelId"
                VisibleIndex="2" PropertiesComboBox-DataSourceID="sdsModel"
                PropertiesComboBox-TextField="VarianName" PropertiesComboBox-ValueField="Id" >
<PropertiesComboBox DataSourceID="sdsModel" TextField="VarianName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>

            <dx:GridViewDataComboBoxColumn Caption="Varian" FieldName="VarianId"
                VisibleIndex="3" PropertiesComboBox-DataSourceID="sdsVarian"
                PropertiesComboBox-TextField="ModelVarian" PropertiesComboBox-ValueField="Id" >
<PropertiesComboBox DataSourceID="sdsVarian" TextField="ModelVarian" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
        </Columns>
        <Templates>
            <DetailRow>
                <div style="padding: 3px 3px 2px 3px">
                    <dx:ASPxPageControl runat="server" ID="pageControl" Width="100%" EnableCallBacks="true">
                        <TabPages>
                            <dx:TabPage Text="Detail1" Visible="true">
                                <ContentCollection>
                                    <dx:ContentControl ID="ContentControl1" runat="server">
                                        <dx:ASPxGridView ID="productsGrid" runat="server" DataSourceID="SqlDataSource2"
                                            KeyFieldName="StationId" Width="100%" OnBeforePerformDataSelect="PlanGrid_DataSelect">
                                            <Columns>
                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="1" />

                                                <dx:GridViewDataComboBoxColumn Caption="Station" FieldName="StationId"
                                                    VisibleIndex="1" PropertiesComboBox-DataSourceID="sdsStation"
                                                    PropertiesComboBox-TextField="StationName" PropertiesComboBox-ValueField="Id" >
                                                </dx:GridViewDataComboBoxColumn>
                                            </Columns>

                                            <Templates>
                                                <DetailRow>
                                                     <div style="padding: 3px 3px 2px 3px">
                                                        <dx:ASPxPageControl runat="server" ID="pageControl2" Width="100%" EnableCallBacks="true">
                                                            <TabPages>
                                                                <dx:TabPage Text="Detail2" Visible="true">
                                                                    <ContentCollection>
                                                                        <dx:ContentControl ID="ContentControl1" runat="server">
                                                                         <dx:ASPxGridView ID="ordersGridView" runat="server" ClientInstanceName="ordersGridView" DataSourceID="SqlDataSource3"
                                                                                KeyFieldName="Id" Width="100%" OnBeforePerformDataSelect="PlanGrid_DataSelect2" >
                                                                                <Columns>
                                                                                    <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                            
                                                                                    <dx:GridViewDataColumn Caption="Id" FieldName="Id" Visible="false" VisibleIndex="0" >
                                                                                    </dx:GridViewDataColumn>

                                                                                    <dx:GridViewDataComboBoxColumn Caption="Assembly Area" FieldName="StationId"
                                                                                        VisibleIndex="1" PropertiesComboBox-DataSourceID="sdsStation"
                                                                                        PropertiesComboBox-TextField="Id" PropertiesComboBox-ValueField="Id" >
                                                                                    </dx:GridViewDataComboBoxColumn>

                                                                                    <dx:GridViewDataComboBoxColumn Caption="Assembly Area Name" FieldName="StationDescription"
                                                                                        VisibleIndex="2" PropertiesComboBox-DataSourceID="sdsStation"
                                                                                        PropertiesComboBox-TextField="StationName" PropertiesComboBox-ValueField="Id" >
                                                                                    </dx:GridViewDataComboBoxColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Sequence" FieldName="Sequence" VisibleIndex="3">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataColumn Caption="PROCESS NO" FieldName="No" VisibleIndex="4">
                                                                                    </dx:GridViewDataColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="PROCESS NAMES" FieldName="ProcessName" VisibleIndex="5">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="CGIS NR" FieldName="CgisNr" VisibleIndex="6">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataHyperLinkColumn Caption="G. WORK INST. NR." FieldName="WorkInst" VisibleIndex="7">                                                                
                                                                                        <EditFormSettings Visible="True" />
                                                                                        <EditItemTemplate>
                                                                                            <input id="hiddenField" name="hiddenField" type="hidden" value=""/>
                                                                                            <dx:ASPxUploadControl ID="ASPxUploadWorkInst" runat="server" Width="280px"  OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete" 
                                                                                                ClientInstanceName="uploader">
                                                                                                </dx:ASPxUploadControl> 

                                                                                                <dx:ASPxButton ID="ASPxButton1" runat="server" AutoPostBack="False" Text="Upload">
                                                                                                    <ClientSideEvents Click="function(s, e) { UploadBtnClick(); }" />
                                                                                                </dx:ASPxButton>
                                                                                        </EditItemTemplate> 
                                                                                    </dx:GridViewDataHyperLinkColumn>
                                                            

                                                                                    <dx:GridViewDataHyperLinkColumn Caption="INSP. INST. NR." FieldName="InspInst" VisibleIndex="8">
                                                                                        <EditFormSettings Visible="True" />
                                                                                        <EditItemTemplate>
                                                                                            <input id="hiddenField2" name="hiddenField2" type="hidden" value=""/>
                                                                                            <dx:ASPxUploadControl ID="ASPxUploadInspInst" runat="server" Width="280px"  OnFileUploadComplete="ASPxUploadControl1_FileUploadComplete2" 
                                                                                                ClientInstanceName="uploader2">
                                                                                                </dx:ASPxUploadControl> 

                                                                                                <dx:ASPxButton ID="ASPxButton2" runat="server" AutoPostBack="False" Text="Upload">
                                                                                                    <ClientSideEvents Click="function(s, e) { UploadBtnClick2(); }" />
                                                                                            </dx:ASPxButton>
                                                                                        </EditItemTemplate> 
                                                                                    </dx:GridViewDataHyperLinkColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="RF" FieldName="Rf" VisibleIndex="9">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="DIALOG ADDRESS" FieldName="DialogAddress" VisibleIndex="10">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="PART NUMBER" FieldName="PartNumber1" VisibleIndex="11">
                                                                                    </dx:GridViewDataTextColumn>
                                                            
                                                                                    <dx:GridViewDataTextColumn Caption="PART DESCRIPTION" FieldName="PartDescription1" VisibleIndex="12">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="QTY" FieldName="Qty" VisibleIndex="13">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="RK" FieldName="Rk" VisibleIndex="14">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="TROLLEY NO." FieldName="TrolleyNo" VisibleIndex="15">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="CLASS" FieldName="Class" VisibleIndex="16">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="V-DOK" FieldName="Vdok" VisibleIndex="17">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="2 HAND" FieldName="Hand" VisibleIndex="18">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="FBS3/4" FieldName="Fbs" VisibleIndex="19">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="DS" FieldName="Ds" VisibleIndex="20">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="CS2" FieldName="Cs2" VisibleIndex="21">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="CS3" FieldName="Cs3" VisibleIndex="22">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="DRT" FieldName="Drt" VisibleIndex="23">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="STAMP NR" FieldName="StampNr" VisibleIndex="24">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                </Columns>
                                                                                        <Templates>
                                                                                            <DetailRow>
                                                                                                 <div style="padding: 3px 3px 2px 3px">
                                                                                                    <dx:ASPxPageControl runat="server" ID="pageControl3" Width="100%" EnableCallBacks="true">
                                                                                                        <TabPages>
                                                                                                            <dx:TabPage Text="Material" Visible="true">
                                                                                                                <ContentCollection>
                                                                                                                    <dx:ContentControl ID="ContentControl2" runat="server">
                                                                                                                        <dx:ASPxGridView ID="ordersGridView2" runat="server" DataSourceID="SqlDataSource4"
                                                                                                                            KeyFieldName="Id" Width="60%" OnBeforePerformDataSelect="PlanGrid_DataSelect3" >
                                                                                                                            <Columns>
                                                                                                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                                                                                                
                                                                                                                                <dx:GridViewDataColumn Caption="Assembly Process No" FieldName="AssemblyProcessNo" VisibleIndex="0">
                                                                                                                                </dx:GridViewDataColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="Assembly Process Name" FieldName="AssemblyProcessName" VisibleIndex="1">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="Consumption Material No" FieldName="ConsumptionMaterialNo" VisibleIndex="2">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataComboBoxColumn Caption="Material Name" FieldName="MaterialId"
                                                                                                                                    VisibleIndex="3" PropertiesComboBox-DataSourceID="sdsMaterial"
                                                                                                                                    PropertiesComboBox-TextField="Name" PropertiesComboBox-ValueField="Id" >
                                                                                                                                </dx:GridViewDataComboBoxColumn>


                                                                                                                                <dx:GridViewDataTextColumn Caption="Quantity" FieldName="Qty" VisibleIndex="4">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="RF" FieldName="RF" VisibleIndex="5">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                            </Columns>
                                                        
                                                                                                                            <Settings ShowFooter="True" />
                                                                                                                        </dx:ASPxGridView>
                                                                                                                        </dx:ContentControl>
                                                                                                                    </ContentCollection>
                                                                                                            </dx:TabPage>
                                                                                                            <dx:TabPage Text="Tools" Visible="true">
                                                                                                                <ContentCollection>
                                                                                                                    <dx:ContentControl ID="ContentControl4" runat="server">
                                                                                                                        <dx:ASPxGridView ID="Tools" runat="server" DataSourceID="SqlDataSource5"
                                                                                                                            KeyFieldName="Id" Width="60%" OnBeforePerformDataSelect="PlanGrid_DataSelect3" >
                                                                                                                            <Columns>
                                                                                                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                                                                                                
                                                                                                                                <dx:GridViewDataColumn Caption="Assembly Process No" FieldName="AssemblyProcessNo" VisibleIndex="0">
                                                                                                                                </dx:GridViewDataColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="Assembly Process Name" FieldName="AssemblyProcessName" VisibleIndex="1">
                                                                                                                                </dx:GridViewDataTextColumn>                                                                                                                               

                                                                                                                                <dx:GridViewDataComboBoxColumn Caption="Description" FieldName="ToolId"
                                                                                                                                    VisibleIndex="3" PropertiesComboBox-DataSourceID="sdsTool"
                                                                                                                                    PropertiesComboBox-TextField="Description" PropertiesComboBox-ValueField="Id" >
                                                                                                                                </dx:GridViewDataComboBoxColumn>


                                                                                                                                <dx:GridViewDataTextColumn Caption="Quantity" FieldName="Qty" VisibleIndex="4">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="RF" FieldName="RF" VisibleIndex="5">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                            </Columns>
                                                        
                                                                                                                            <Settings ShowFooter="True" />
                                                                                                                        </dx:ASPxGridView>
                                                                                                                        </dx:ContentControl>
                                                                                                                    </ContentCollection>
                                                                                                            </dx:TabPage>
                                                                                                            <dx:TabPage Text="Old Material" Visible="true">
                                                                                                                <ContentCollection>
                                                                                                                    <dx:ContentControl ID="ContentControl6" runat="server">
                                                                                                                        <dx:ASPxGridView ID="OldMaterial" runat="server" DataSourceID="SqlDataSource4"
                                                                                                                            KeyFieldName="Id" Width="60%" OnBeforePerformDataSelect="PlanGrid_DataSelect3" >
                                                                                                                            <Columns>
                                                                                                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                                                                                                
                                                                                                                                <dx:GridViewDataColumn Caption="Assembly Process No" FieldName="AssemblyProcessNo" VisibleIndex="0">
                                                                                                                                </dx:GridViewDataColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="Assembly Process Name" FieldName="AssemblyProcessName" VisibleIndex="1">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="Consumption Material No" FieldName="ConsumptionMaterialNo" VisibleIndex="2">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataComboBoxColumn Caption="Material Name" FieldName="MaterialId"
                                                                                                                                    VisibleIndex="3" PropertiesComboBox-DataSourceID="sdsMaterial"
                                                                                                                                    PropertiesComboBox-TextField="Name" PropertiesComboBox-ValueField="Id" >
                                                                                                                                </dx:GridViewDataComboBoxColumn>


                                                                                                                                <dx:GridViewDataTextColumn Caption="Quantity" FieldName="Qty" VisibleIndex="4">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="RF" FieldName="RF" VisibleIndex="5">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                            </Columns>
                                                        
                                                                                                                            <Settings ShowFooter="True" />
                                                                                                                        </dx:ASPxGridView>
                                                                                                                        </dx:ContentControl>
                                                                                                                    </ContentCollection>
                                                                                                            </dx:TabPage>
                                                                                                            <dx:TabPage Text="Old Tools" Visible="true">
                                                                                                                <ContentCollection>
                                                                                                                    <dx:ContentControl ID="ContentControl3" runat="server">
                                                                                                                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" DataSourceID="SqlDataSource5"
                                                                                                                            KeyFieldName="Id" Width="60%" OnBeforePerformDataSelect="PlanGrid_DataSelect3" >
                                                                                                                            <Columns>
                                                                                                                                <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="0" />
                                                                                                                                
                                                                                                                                <dx:GridViewDataColumn Caption="Assembly Process No" FieldName="AssemblyProcessNo" VisibleIndex="0">
                                                                                                                                </dx:GridViewDataColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="Assembly Process Name" FieldName="AssemblyProcessName" VisibleIndex="1">
                                                                                                                                </dx:GridViewDataTextColumn>                                                                                                                               

                                                                                                                                <dx:GridViewDataComboBoxColumn Caption="Description" FieldName="ToolId"
                                                                                                                                    VisibleIndex="3" PropertiesComboBox-DataSourceID="sdsTool"
                                                                                                                                    PropertiesComboBox-TextField="Description" PropertiesComboBox-ValueField="Id" >
                                                                                                                                </dx:GridViewDataComboBoxColumn>


                                                                                                                                <dx:GridViewDataTextColumn Caption="Quantity" FieldName="Qty" VisibleIndex="4">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                                <dx:GridViewDataTextColumn Caption="RF" FieldName="RF" VisibleIndex="5">
                                                                                                                                </dx:GridViewDataTextColumn>

                                                                                                                            </Columns>
                                                        
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
                                                                                    <SettingsDetail ShowDetailRow="true" />
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
                                            
                                            <SettingsDetail ShowDetailRow="true" />
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


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT * FROM [ControlPlan]" DeleteCommand="DELETE FROM [ControlPlan] WHERE [Id] = @Id" InsertCommand="INSERT INTO [ControlPlan] ([PackingMonthId], [ModelId], [VarianId]) VALUES (@PackingMonthId, @ModelId, @VarianId)" UpdateCommand="UPDATE [ControlPlan] SET [PackingMonthId] = @PackingMonthId, [ModelId] = @ModelId, [VarianId] = @VarianId WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>

    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT * FROM [ControlPlanDetail] WHERE ([ControlPlanId] = @ControlPlanId)" DeleteCommand="DELETE FROM [ControlPlanDetail] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [ControlPlanDetail] ([ControlPlanId], [StationId]) VALUES (@ControlPlanId2, @StationId)" UpdateCommand="UPDATE [ControlPlanDetail] SET [ControlPlanId] = @ControlPlanId, [StationId] = @StationId WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter Name="ControlPlanId2" SessionField="SessionId2" Type="int32" DefaultValue="0" />
            <asp:Parameter Name="ControlPlanId" Type="Int32" />
            <asp:Parameter Name="StationId" Type="String" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="ControlPlanId" SessionField="SessionId" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ControlPlanId" Type="Int32" />
            <asp:Parameter Name="StationId" Type="String" />
            <asp:Parameter Name="original_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="OldT" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" DeleteCommand="DELETE FROM [ControlPlanDetail5] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [ControlPlanDetail5] ([ControlPlanDetail1Id], [AssemblyProcessNo], [AssemblyProcessName],  [ToolId], [Qty], [RF], [ControlPlanId]) VALUES (@ControlPlanDetail1Id, @AssemblyProcessNo, @AssemblyProcessName, @ConsumptionMaterialNo, @MaterialId, @Qty, @RF, @ControlPlanId)" SelectCommand="SELECT * FROM [ControlPlanDetail5] WHERE ([ControlPlanDetail1Id] = @ControlPlanDetail1Id)" UpdateCommand="UPDATE [ControlPlanDetail5] SET [ControlPlanDetail1Id] = @ControlPlanDetail1Id, [AssemblyProcessNo] = @AssemblyProcessNo, [AssemblyProcessName] = @AssemblyProcessName, [ToolId] = @ToolId, [Qty] = @Qty, [RF] = @RF, [ControlPlanId] = @ControlPlanId WHERE [Id] = @original_Id">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" />
            <asp:Parameter Name="AssemblyProcessNo" />
            <asp:Parameter Name="AssemblyProcessName" />
            <asp:Parameter Name="ConsumptionMaterialNo" />
            <asp:Parameter Name="MaterialId" />
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="RF" />
            <asp:Parameter Name="ControlPlanId" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="ControlPlanDetail1Id" SessionField="SessionId5" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" />
            <asp:Parameter Name="AssemblyProcessNo" />
            <asp:Parameter Name="AssemblyProcessName" />
            <asp:Parameter Name="ToolId" />
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="RF" />
            <asp:Parameter Name="ControlPlanId" />
            <asp:Parameter Name="original_Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT *, Id ControlPlanDetail1Id FROM [ControlPlanDetail1] WHERE ([StationId] = @StationId)" 
        DeleteCommand="DELETE FROM [ControlPlanDetail1] WHERE [Id] = @original_Id" 
        InsertCommand="INSERT INTO [ControlPlanDetail1] ([ControlPlanId], [No], [ProcessName], [CgisNr], [WorkInst], [InspInst], [Rf], [DialogAddress], [PartNumber], [PartDescription], [Qty], [Rk], [TrolleyNo], [Class], [Vdok], [Hand], [Fbs], [Ds], [Cs2], [Cs3], [Drt], [StampNr], [StationId], [NoUrut], [Sequence], [PartNumber1], [PartDescription1], [StationDescription]) VALUES (@ControlPlanId, @No, @ProcessName, @CgisNr, @WorkInst, @InspInst, @Rf, @DialogAddress, @PartNumber, @PartDescription, @Qty, @Rk, @TrolleyNo, @Class, @Vdok, @Hand, @Fbs, @Ds, @Cs2, @Cs3, @Drt, @StampNr, @StationId, @NoUrut, @Sequence, @PartNumber1, @PartDescription1, @StationDescription)" 
        UpdateCommand="UPDATE [ControlPlanDetail1] SET [ControlPlanId] = @ControlPlanId, [No] = @No, [ProcessName] = @ProcessName, [CgisNr] = @CgisNr, [WorkInst] = @WorkInst, [InspInst] = @InspInst, [Rf] = @Rf, [DialogAddress] = @DialogAddress, [PartNumber] = @PartNumber, [PartDescription] = @PartDescription, [Qty] = @Qty, [Rk] = @Rk, [TrolleyNo] = @TrolleyNo, [Class] = @Class, [Vdok] = @Vdok, [Hand] = @Hand, [Fbs] = @Fbs, [Ds] = @Ds, [Cs2] = @Cs2, [Cs3] = @Cs3, [Drt] = @Drt, [StampNr] = @StampNr, [StationId] = @StationId, [NoUrut] = @NoUrut, [Sequence] = @Sequence, [PartNumber1] = @PartNumber1, [PartDescription1] = @PartDescription1, [StationDescription] = @StationDescription WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ControlPlanId" Type="Int32" />
            <asp:Parameter Name="No" Type="Int32" />
            <asp:Parameter Name="ProcessName" Type="String" />
            <asp:Parameter Name="CgisNr" Type="String" />
            <asp:Parameter Name="WorkInst" Type="String" />
            <asp:Parameter Name="InspInst" Type="String" />
            <asp:Parameter Name="Rf" Type="String" />
            <asp:Parameter Name="DialogAddress" Type="String" />
            <asp:Parameter Name="PartNumber" Type="Int32" />
            <asp:Parameter Name="PartDescription" Type="Int32" />
            <asp:Parameter Name="Qty" Type="Decimal" />
            <asp:Parameter Name="Rk" Type="String" />
            <asp:Parameter Name="TrolleyNo" Type="Int32" />
            <asp:Parameter Name="Class" Type="String" />
            <asp:Parameter Name="Vdok" Type="String" />
            <asp:Parameter Name="Hand" Type="String" />
            <asp:Parameter Name="Fbs" Type="String" />
            <asp:Parameter Name="Ds" Type="String" />
            <asp:Parameter Name="Cs2" Type="String" />
            <asp:Parameter Name="Cs3" Type="String" />
            <asp:Parameter Name="Drt" Type="String" />
            <asp:Parameter Name="StampNr" Type="String" />
            <asp:Parameter Name="StationId" Type="Int32" />
            <asp:Parameter Name="NoUrut" Type="Int32" />
            <asp:Parameter Name="Sequence" Type="String" />
            <asp:Parameter Name="PartNumber1" Type="String" />
            <asp:Parameter Name="PartDescription1" Type="String" />
            <asp:Parameter Name="StationDescription" Type="Int32" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="StationId" SessionField="SessionId4" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ControlPlanId" Type="Int32" />
            <asp:Parameter Name="No" Type="Int32" />
            <asp:Parameter Name="ProcessName" Type="String" />
            <asp:Parameter Name="CgisNr" Type="String" />
            <asp:Parameter Name="WorkInst" Type="String" />
            <asp:Parameter Name="InspInst" Type="String" />
            <asp:Parameter Name="Rf" Type="String" />
            <asp:Parameter Name="DialogAddress" Type="String" />
            <asp:Parameter Name="PartNumber" Type="Int32" />
            <asp:Parameter Name="PartDescription" Type="Int32" />
            <asp:Parameter Name="Qty" Type="Decimal" />
            <asp:Parameter Name="Rk" Type="String" />
            <asp:Parameter Name="TrolleyNo" Type="Int32" />
            <asp:Parameter Name="Class" Type="String" />
            <asp:Parameter Name="Vdok" Type="String" />
            <asp:Parameter Name="Hand" Type="String" />
            <asp:Parameter Name="Fbs" Type="String" />
            <asp:Parameter Name="Ds" Type="String" />
            <asp:Parameter Name="Cs2" Type="String" />
            <asp:Parameter Name="Cs3" Type="String" />
            <asp:Parameter Name="Drt" Type="String" />
            <asp:Parameter Name="StampNr" Type="String" />
            <asp:Parameter Name="StationId" Type="Int32" />
            <asp:Parameter Name="NoUrut" Type="Int32" />
            <asp:Parameter Name="Sequence" Type="String" />
            <asp:Parameter Name="PartNumber1" Type="String" />
            <asp:Parameter Name="PartDescription1" Type="String" />
            <asp:Parameter Name="StationDescription" Type="Int32" />
            <asp:Parameter Name="original_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="OldM" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" DeleteCommand="DELETE FROM [ControlPlanDetail4] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [ControlPlanDetail4] ([ControlPlanDetail1Id], [AssemblyProcessNo], [AssemblyProcessName], [ConsumptionMaterialNo], [MaterialId], [Qty], [RF], [ControlPlanId]) VALUES (@ControlPlanDetail1Id, @AssemblyProcessNo, @AssemblyProcessName, @ConsumptionMaterialNo, @MaterialId, @Qty, @RF, @ControlPlanId)" SelectCommand="SELECT * FROM [ControlPlanDetail4] WHERE ([ControlPlanDetail1Id] = @ControlPlanDetail1Id)" UpdateCommand="UPDATE [ControlPlanDetail4] SET [ControlPlanDetail1Id] = @ControlPlanDetail1Id, [AssemblyProcessNo] = @AssemblyProcessNo, [AssemblyProcessName] = @AssemblyProcessName, [ConsumptionMaterialNo] = @ConsumptionMaterialNo, [MaterialId] = @MaterialId, [Qty] = @Qty, [RF] = @RF, [ControlPlanId] = @ControlPlanId WHERE [Id] = @original_Id">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" />
            <asp:Parameter Name="AssemblyProcessNo" />
            <asp:Parameter Name="AssemblyProcessName" />
            <asp:Parameter Name="ConsumptionMaterialNo" />
            <asp:Parameter Name="MaterialId" />
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="RF" />
            <asp:Parameter Name="ControlPlanId" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="ControlPlanDetail1Id" SessionField="SessionId5" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" />
            <asp:Parameter Name="AssemblyProcessNo" />
            <asp:Parameter Name="AssemblyProcessName" />
            <asp:Parameter Name="ConsumptionMaterialNo" />
            <asp:Parameter Name="MaterialId" />
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="RF" />
            <asp:Parameter Name="ControlPlanId" />
            <asp:Parameter Name="original_Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT * FROM [ControlPlanDetail2] WHERE ([ControlPlanDetail1Id] = @ControlPlanDetail1Id)" 
        DeleteCommand="DELETE FROM [ControlPlanDetail2] WHERE [Id] = @original_Id" 
        InsertCommand="INSERT INTO [ControlPlanDetail2] ([ControlPlanDetail1Id], [AssemblyProcessNo], [AssemblyProcessName], [ConsumptionMaterialNo], [MaterialId], [Qty], [RF], [ControlPlanId]) VALUES (@ControlPlanDetail1Id, @AssemblyProcessNo, @AssemblyProcessName, @ConsumptionMaterialNo, @MaterialId, @Qty, @RF, @ControlPlanId)" 
        UpdateCommand="UPDATE [ControlPlanDetail2] SET [ControlPlanDetail1Id] = @ControlPlanDetail1Id, [AssemblyProcessNo] = @AssemblyProcessNo, [AssemblyProcessName] = @AssemblyProcessName, [ConsumptionMaterialNo] = @ConsumptionMaterialNo, [MaterialId] = @MaterialId, [Qty] = @Qty, [RF] = @RF, [ControlPlanId] = @ControlPlanId WHERE [Id] = @original_Id" OldValuesParameterFormatString="original_{0}">

        <DeleteParameters>
            <asp:Parameter Name="original_Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" Type="Int32" />
            <asp:Parameter Name="AssemblyProcessNo" Type="String" />
            <asp:Parameter Name="AssemblyProcessName" Type="String" />
            <asp:Parameter Name="ConsumptionMaterialNo" Type="String" />
            <asp:Parameter Name="MaterialId" Type="Int32" />
            <asp:Parameter Name="Qty" Type="Int32" />
            <asp:Parameter Name="RF" Type="String" />
            <asp:Parameter Name="ControlPlanId" Type="Int32" />
        </InsertParameters>

        <SelectParameters>
            <asp:SessionParameter Name="ControlPlanDetail1Id" SessionField="SessionId5" Type="int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" Type="Int32" />
            <asp:Parameter Name="AssemblyProcessNo" Type="String" />
            <asp:Parameter Name="AssemblyProcessName" Type="String" />
            <asp:Parameter Name="ConsumptionMaterialNo" Type="String" />
            <asp:Parameter Name="MaterialId" Type="Int32" />
            <asp:Parameter Name="Qty" Type="Int32" />
            <asp:Parameter Name="RF" Type="String" />
            <asp:Parameter Name="ControlPlanId" Type="Int32" />
            <asp:Parameter Name="original_Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModel" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, VarianCode, VarianName from Varians Order by VarianName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsVarian" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, VarianId, ModelVarian from VarianDetails Order by ModelVarian">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsMaterial" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT * FROM [Materials]">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsTool" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" SelectCommand="SELECT * FROM [ToolSetup]"></asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsStation" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, StationName from Stations Order by StationName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource5" runat="server" ConnectionString="<%$ ConnectionStrings:AppDb %>" DeleteCommand="DELETE FROM [ControlPlanDetail3] WHERE [Id] = @original_Id" InsertCommand="INSERT INTO [ControlPlanDetail3] ([ControlPlanDetail1Id], [AssemblyProcessNo], [AssemblyProcessName],  [ToolId], [Qty], [RF], [ControlPlanId]) VALUES (@ControlPlanDetail1Id, @AssemblyProcessNo, @AssemblyProcessName, @ToolId, @Qty, @RF, @ControlPlanId)" SelectCommand="SELECT * FROM [ControlPlanDetail3] WHERE ([ControlPlanDetail1Id] = @ControlPlanDetail1Id)" UpdateCommand="UPDATE [ControlPlanDetail3] SET [ControlPlanDetail1Id] = @ControlPlanDetail1Id, [AssemblyProcessNo] = @AssemblyProcessNo, [AssemblyProcessName] = @AssemblyProcessName, [ToolId] = @ToolId, [Qty] = @Qty, [RF] = @RF, [ControlPlanId] = @ControlPlanId WHERE [Id] = @original_Id">
        <DeleteParameters>
            <asp:Parameter Name="original_Id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" />
            <asp:Parameter Name="AssemblyProcessNo" />
            <asp:Parameter Name="AssemblyProcessName" />
            <asp:Parameter Name="ToolId" />
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="RF" />
            <asp:Parameter Name="ControlPlanId" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="ControlPlanDetail1Id" SessionField="SessionId5" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="ControlPlanDetail1Id" />
            <asp:Parameter Name="AssemblyProcessNo" />
            <asp:Parameter Name="AssemblyProcessName" />
            <asp:Parameter Name="ToolId" />
            <asp:Parameter Name="Qty" />
            <asp:Parameter Name="RF" />
            <asp:Parameter Name="ControlPlanId" />
            <asp:Parameter Name="original_Id" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPackingMonth" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select  Id, PackingMth from PackingMonths Order by PackingMth">                   
    </asp:SqlDataSource>

</asp:Content>
