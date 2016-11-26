<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="STAView.aspx.cs" Inherits="DotMercy.custom.STAView" %>

<asp:Content ID="Content" ContentPlaceHolderID="MainContent" runat="server">
	<dx:ASPxGridView ID="masterGrid" runat="server" AutoGenerateColumns="False" DataSourceID="masterDataSource" ClientInstanceName="masterGrid"
		Width="60%" KeyFieldName="Id" CssClass="gridView">
		<Columns>
            <dx:GridViewCommandColumn ShowNewButtonInHeader="False" VisibleIndex="0">
				<HeaderCaptionTemplate>
					<dx:ASPxHyperLink ID="btnNew" runat="server" Text="New">
						<ClientSideEvents Click="function (s, e) { masterGrid.AddNewRow();}" />
					</dx:ASPxHyperLink>
				</HeaderCaptionTemplate>
			</dx:GridViewCommandColumn>

            <dx:GridViewDataTextColumn FieldName="Id" VisibleIndex="0" ReadOnly="True">
                <EditFormSettings Visible="False" />
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="Issuer" VisibleIndex="1">
                <PropertiesComboBox DataSourceID="sdsUser" TextField="UserName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataDateColumn FieldName="IssuedDate" VisibleIndex="2"></dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn FieldName="RICStatusId" VisibleIndex="3">
                <PropertiesComboBox DataSourceID="sdsRICStatus" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="RICNR" VisibleIndex="4"></dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="AlterationId" VisibleIndex="5">
                <PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ReasonOfAlterationId" VisibleIndex="6">
                <PropertiesComboBox DataSourceID="sdsAlteration" TextField="Reason" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="COMNOS" VisibleIndex="7">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="PackingMonthId" VisibleIndex="8">
                <PropertiesComboBox DataSourceID="sdsPackingMonth" TextField="PackingMth" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            
            <dx:GridViewDataTextColumn FieldName="IMPLPLAN" VisibleIndex="10">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataCheckColumn FieldName="Remark" VisibleIndex="11"></dx:GridViewDataCheckColumn>
            <dx:GridViewDataTextColumn FieldName="Codes" VisibleIndex="12"></dx:GridViewDataTextColumn>
            <dx:GridViewDataDateColumn FieldName="OldUntil" VisibleIndex="13"></dx:GridViewDataDateColumn>
            <dx:GridViewDataDateColumn FieldName="NewFrom" VisibleIndex="14"></dx:GridViewDataDateColumn>
            <dx:GridViewDataComboBoxColumn FieldName="CreatedById" VisibleIndex="15">
                <PropertiesComboBox DataSourceID="sdsOrganization" TextField="Name" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataTextColumn FieldName="ApproveBy" VisibleIndex="16">
            </dx:GridViewDataTextColumn>
            <dx:GridViewDataComboBoxColumn FieldName="ModelId" VisibleIndex="17">
                <PropertiesComboBox DataSourceID="sdsModel" TextField="VarianName" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            <dx:GridViewDataComboBoxColumn FieldName="VarianId" VisibleIndex="18">
                <PropertiesComboBox DataSourceID="sdsVarian" TextField="ModelVarian" ValueField="Id"></PropertiesComboBox>
            </dx:GridViewDataComboBoxColumn>
            
		</Columns>

        <Templates>
            <DetailRow>
                <dx:ASPxGridView ID="detailGrid" runat="server" DataSourceID="SqlDataSource2" KeyFieldName="Id"
                    Width="100%" OnBeforePerformDataSelect="detailGrid_DataSelect">
                    <Columns>
                        
                        <dx:GridViewCommandColumn ShowNewButtonInHeader="true" ShowEditButton="true" ShowDeleteButton="true" VisibleIndex="1" />

                        <dx:GridViewDataTextColumn FieldName="OldPartNumber" VisibleIndex="2"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OldDescription" VisibleIndex="3"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OldQty" VisibleIndex="4"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="OldESD" VisibleIndex="5"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NewPartNumber" VisibleIndex="6"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NewDescription" VisibleIndex="7"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NewQty" VisibleIndex="8"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn FieldName="NewESD" VisibleIndex="9"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="ID" FieldName="NewID" VisibleIndex="10"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Index" FieldName="NewIndex" VisibleIndex="11"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Dialog Address" FieldName="NewDialogAddress" VisibleIndex="12"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Assy" FieldName="NewAssy" VisibleIndex="13"></dx:GridViewDataTextColumn>
                        <dx:GridViewDataTextColumn Caption="Remark" FieldName="NewRemark" VisibleIndex="14"></dx:GridViewDataTextColumn>
                    </Columns>
                </dx:ASPxGridView>
            </DetailRow>
        </Templates>

   		<SettingsPager PageSize="32" />
		<Paddings Padding="0px" />
		<Border BorderWidth="0px" />
		<BorderBottom BorderWidth="1px" />
		<Settings ShowGroupPanel="True" />
        <SettingsDetail ShowDetailRow="true" />
    </dx:ASPxGridView>

    <asp:SqlDataSource ID="masterDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [Issuer], [IssuedDate], [RICStatusId], [RICNR], [AlterationId], [ReasonOfAlterationId], [COMNOS], [PackingMonthId], [ChassisNR], [IMPLPLAN], [Remark], [Codes], [OldUntil], [NewFrom], [CreatedById], [ApproveBy], [ModelId], [VarianId] FROM [RecordImplemControl]" 
        DeleteCommand="DELETE FROM [RecordImplemControl] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [RecordImplemControl] ([Issuer], [IssuedDate], [RICStatusId], [RICNR], [AlterationId], [ReasonOfAlterationId], [COMNOS], [PackingMonthId], [ChassisNR], [IMPLPLAN], [Remark], [Codes], [OldUntil], [NewFrom], [CreatedById], [ApproveBy], [ModelId], [VarianId]) VALUES (@Issuer, @IssuedDate, @RICStatusId, @RICNR, @AlterationId, @ReasonOfAlterationId, @COMNOS, @PackingMonthId, @ChassisNR, @IMPLPLAN, @Remark, @Codes, @OldUntil, @NewFrom, @CreatedById, @ApproveBy, @ModelId, @VarianId)" 
        UpdateCommand="UPDATE [RecordImplemControl] SET [Issuer] = @Issuer, [IssuedDate] = @IssuedDate, [RICStatusId] = @RICStatusId, [RICNR] = @RICNR, [AlterationId] = @AlterationId, [ReasonOfAlterationId] = @ReasonOfAlterationId, [COMNOS] = @COMNOS, [PackingMonthId] = @PackingMonthId, [ChassisNR] = @ChassisNR, [IMPLPLAN] = @IMPLPLAN, [Remark] = @Remark, [Codes] = @Codes, [OldUntil] = @OldUntil, [NewFrom] = @NewFrom, [CreatedById] = @CreatedById, [ApproveBy] = @ApproveBy, [ModelId] = @ModelId, [VarianId] = @VarianId WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Issuer" Type="Int32" />
            <asp:Parameter DbType="Date" Name="IssuedDate" />
            <asp:Parameter Name="RICStatusId" Type="Int32" />
            <asp:Parameter Name="RICNR" Type="String" />
            <asp:Parameter Name="AlterationId" Type="Int32" />
            <asp:Parameter Name="ReasonOfAlterationId" Type="Int32" />
            <asp:Parameter Name="COMNOS" Type="String" />
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="ChassisNR" Type="String" />
            <asp:Parameter Name="IMPLPLAN" Type="String" />
            <asp:Parameter Name="Remark" Type="Boolean" />
            <asp:Parameter Name="Codes" Type="String" />
            <asp:Parameter DbType="Date" Name="OldUntil" />
            <asp:Parameter DbType="Date" Name="NewFrom" />
            <asp:Parameter Name="CreatedById" Type="Int32" />
            <asp:Parameter Name="ApproveBy" Type="String" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Issuer" Type="Int32" />
            <asp:Parameter DbType="Date" Name="IssuedDate" />
            <asp:Parameter Name="RICStatusId" Type="Int32" />
            <asp:Parameter Name="RICNR" Type="String" />
            <asp:Parameter Name="AlterationId" Type="Int32" />
            <asp:Parameter Name="ReasonOfAlterationId" Type="Int32" />
            <asp:Parameter Name="COMNOS" Type="String" />
            <asp:Parameter Name="PackingMonthId" Type="Int32" />
            <asp:Parameter Name="ChassisNR" Type="String" />
            <asp:Parameter Name="IMPLPLAN" Type="String" />
            <asp:Parameter Name="Remark" Type="Boolean" />
            <asp:Parameter Name="Codes" Type="String" />
            <asp:Parameter DbType="Date" Name="OldUntil" />
            <asp:Parameter DbType="Date" Name="NewFrom" />
            <asp:Parameter Name="CreatedById" Type="Int32" />
            <asp:Parameter Name="ApproveBy" Type="String" />
            <asp:Parameter Name="ModelId" Type="Int32" />
            <asp:Parameter Name="VarianId" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsOrganization" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, Name, Code, Decsription from Organizations Order by Name">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="SELECT [Id], [RICId], [OldNo], [OldQty], [OldESD], [OldPartNumber], [NewRemark], [NewAssy], [NewDialogAddress], [NewIndex], [NewID], [NewESD], [NewQty], [OldDescription], [NewPartNumber], [NewDescription], [PartNumberGab] FROM [RecordImplemControlDetail] WHERE ([RICId] = @RICId)" 
        DeleteCommand="DELETE FROM [RecordImplemControlDetail] WHERE [Id] = @Id" 
        InsertCommand="INSERT INTO [RecordImplemControlDetail] ([RICId], [OldNo], [OldQty], [OldESD], [OldPartNumber], [NewRemark], [NewAssy], [NewDialogAddress], [NewIndex], [NewID], [NewESD], [NewQty], [OldDescription], [NewPartNumber], [NewDescription], [PartNumberGab]) VALUES (@RICId2, @OldNo, @OldQty, @OldESD, @OldPartNumber, @NewRemark, @NewAssy, @NewDialogAddress, @NewIndex, @NewID, @NewESD, @NewQty, @OldDescription, @NewPartNumber, @NewDescription, @PartNumberGab)" UpdateCommand="UPDATE [RecordImplemControlDetail] SET [RICId] = @RICId, [OldNo] = @OldNo, [OldQty] = @OldQty, [OldESD] = @OldESD, [OldPartNumber] = @OldPartNumber, [NewRemark] = @NewRemark, [NewAssy] = @NewAssy, [NewDialogAddress] = @NewDialogAddress, [NewIndex] = @NewIndex, [NewID] = @NewID, [NewESD] = @NewESD, [NewQty] = @NewQty, [OldDescription] = @OldDescription, [NewPartNumber] = @NewPartNumber, [NewDescription] = @NewDescription, [PartNumberGab] = @PartNumberGab WHERE [Id] = @Id">
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:SessionParameter DefaultValue="0" Name="RICId2" SessionField="sessiionRICId2" Type="Int32" />
            <asp:Parameter Name="RICId" Type="Int32" />
            <asp:Parameter Name="OldNo" Type="Int32" />
            <asp:Parameter Name="OldQty" Type="Decimal" />
            <asp:Parameter Name="OldESD" Type="String" />
            <asp:Parameter Name="OldPartNumber" Type="String" />
            <asp:Parameter Name="NewRemark" Type="String" />
            <asp:Parameter Name="NewAssy" Type="String" />
            <asp:Parameter Name="NewDialogAddress" Type="String" />
            <asp:Parameter Name="NewIndex" Type="String" />
            <asp:Parameter Name="NewID" Type="String" />
            <asp:Parameter Name="NewESD" Type="String" />
            <asp:Parameter Name="NewQty" Type="Decimal" />
            <asp:Parameter Name="OldDescription" Type="String" />
            <asp:Parameter Name="NewPartNumber" Type="String" />
            <asp:Parameter Name="NewDescription" Type="String" />
            <asp:Parameter Name="PartNumberGab" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="RICId" SessionField="sessiionRICId" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="RICId" Type="Int32" />
            <asp:Parameter Name="OldNo" Type="Int32" />
            <asp:Parameter Name="OldQty" Type="Decimal" />
            <asp:Parameter Name="OldESD" Type="String" />
            <asp:Parameter Name="OldPartNumber" Type="String" />
            <asp:Parameter Name="NewRemark" Type="String" />
            <asp:Parameter Name="NewAssy" Type="String" />
            <asp:Parameter Name="NewDialogAddress" Type="String" />
            <asp:Parameter Name="NewIndex" Type="String" />
            <asp:Parameter Name="NewID" Type="String" />
            <asp:Parameter Name="NewESD" Type="String" />
            <asp:Parameter Name="NewQty" Type="Decimal" />
            <asp:Parameter Name="OldDescription" Type="String" />
            <asp:Parameter Name="NewPartNumber" Type="String" />
            <asp:Parameter Name="NewDescription" Type="String" />
            <asp:Parameter Name="PartNumberGab" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsAlteration" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, Reason from Alterations Order by Reason">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsPackingMonth" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, PackingMth from PackingMonths Order by PackingMth">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsRICStatus" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, Name from RICStatus Order by Name">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsUser" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, UserID, UserName, Password, OrganizationId from Users Order by UserName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsModel" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, VarianCode, VarianName from Varians Order by VarianName">                   
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="sdsVarian" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AppDb %>" 
        SelectCommand="Select Id, ModelVarian from VarianDetails Order by ModelVarian">                   
    </asp:SqlDataSource>


</asp:Content>
