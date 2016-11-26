<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ReportViewer_.aspx.cs" Inherits="DotMercy.custom.Report.ReportViewer_" %>
<%@ Register assembly="DevExpress.XtraReports.v14.2.Web, Version=14.2.13.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <table>
        </table>
    
   
    <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" runat="server" ClientInstanceName="ASPxDocumentViewer1" EnableViewState="false" >
        <SettingsReportViewer EnableRequestParameters="False" />
        <SettingsDocumentMap ShowTreeLines="True" AllowSelectNode="true" /> 
    </dx:ASPxDocumentViewer>
</asp:Content>
