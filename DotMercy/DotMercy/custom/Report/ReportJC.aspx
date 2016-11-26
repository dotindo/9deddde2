<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ReportJC.aspx.cs" Inherits="DotMercy.custom.Report.ReportJC" %>
<%@ Register assembly="DevExpress.XtraReports.v14.2.Web, Version=14.2.13.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" runat="server"
        ClientInstanceName ="ASPxDocumentViewer1">
        <SettingsReportViewer EnableRequestParameters="False" />
    </dx:ASPxDocumentViewer>
</asp:Content>
