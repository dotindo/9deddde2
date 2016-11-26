<%@ Page Title="" Language="C#" MasterPageFile="~/Main.master" AutoEventWireup="true" CodeBehind="ReportMenu.aspx.cs" Inherits="DotMercy.custom.ReportMenu" %>


<%@ Register assembly="DevExpress.XtraReports.v15.2.Web, Version=15.2.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>


<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="server">

    <script type="text/javascript">
            
            function FileType_SelectedIndexChanged(s, e) {
                //FileType.FileType_SelectedIndexChanged = s.GetValue().toString();
                //FileType.PerformCallback(s.GetValue().toString()); 
                
            }

            /* UPLOAD CONTROL DATA UJI */
            function UpdateUploadButton() {
                btnUpload_DataUji.SetEnabled(UcDataUji.GetText(0) != "");
            }

            function UcDataUji_OnUploadStart() {
                btnUpload_DataUji.SetText('Uploading...');
                UpdateUploadButton();
            }

            function UcDataUji_OnFileUploadComplete(args) {

                if (args.isValid && args.callbackData != "") {

                    src = args.callbackData;
                    arrSplit = src.split("|");
                    tb_attach_filename.SetText(arrSplit[0]);
                    tb_attach_filename.Validate();

                } else {
                    if (args.isValid) {
                        alert("Import Data Sucessfully");
                    } else {
                        alert("Error Import Data");
                    }
                    //alert(args.errorText);
                    btnUpload_DataUji.SetText("Uploaded");
                }
            }

    </script>

    <div id="MainContainer" runat="server">
        
        
            <table width="50%" cellpadding="5" style="width:50%; margin-left: 30px" class="dxgvEditFormTable">

                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>

                <tr>
                    <td colspan="3" style="font-weight: bold; font-size:medium"></td>
                </tr>

                <tr>
                    <td colspan="3">&nbsp;</td>
                </tr>

                <tr>                                                               
                    <td class="tdEditFormCell" colspan="3" style="width: 10%" align="left">
                        <dx:ASPxButton ID="btnProcess" runat="server" AutoPostBack="False" 
							ClientInstanceName="btnProcess" Text="Report Test" OnClick="FileType_SelectedIndexChanged">
                            
                        </dx:ASPxButton>
                    </td>
                </tr>


            </table>

            <dx:ASPxPopupControl ID="pucReport" runat="server" Width="890px" Height="600px"
                    ClientInstanceName="pucReport" CloseAction="CloseButton"
                    HeaderText="Print" Modal="True" ShowPageScrollbarWhenModal="True"
                    PopupVerticalAlign="TopSides" PopupHorizontalAlign="WindowCenter" ScrollBars="Vertical">
                    <ClientSideEvents CloseUp="pucReport_CloseUp" Closing="pucReport_Closing" />
                    <ContentCollection>
                        <dx:PopupControlContentControl runat="server" SupportsDisabledAttribute="True">
                            <table width="100%">
                                <tr>
                                   
                                    <td>
                                        
                                        
                                           
                                     </td> 
                                </tr>
                            </table>
                        </dx:PopupControlContentControl>
                    </ContentCollection>
                </dx:ASPxPopupControl>
       
        
    </div>

	</asp:Content>
