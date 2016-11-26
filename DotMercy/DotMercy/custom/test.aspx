<%@ Page Title="" Language="C#" MaintainScrollPositionOnPostback="true"   MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="DotMercy.custom.test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        function x() {

            PageMethods.F1(onSucess, onError);

            function onSucess(result) {
                alert('Success');
            }

            function onError(result) {
                alert('Something wrong.');
            }
        }
    </script>
    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="ASPxButton"  ClientInstanceName="ASPxButton1" >
        <ClientSideEvents Click="function(s, e) {x();}" />
    </dx:ASPxButton>
    
    
    
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods ="true" >
    </asp:ScriptManager>
    
    
    
</asp:Content>
