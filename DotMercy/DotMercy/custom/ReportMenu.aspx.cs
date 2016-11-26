using DevExpress.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Data.OleDb;
//using DotMercy.custom.PrintOut;
using DevExpress.XtraReports.UI;

namespace DotMercy.custom
{
    public partial class ReportMenu : System.Web.UI.Page
    {
        public static int GetdataSave_mVarianId = 0;
        public static string GetdataSave_mVarianName = "";

        public static int GetdataSave_mModelId = 0;
        public static string GetdataSave_mModelName = "";

        public static int GetdataSave_mPackingMonth = 0;
        public static string GetdataSave_mPackingMonthName = "";

        public static int GetdataSave_mFileType = 0;
        public static string GetdataSave_mFileTypeName = "";
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsCallback && !IsPostBack)
            {

                //VarianId.SelectedIndex = 0;
                //grid.DataBind();
                //grid.DetailRows.ExpandRow(0);
            }
        }
        protected void PlanGrid_DataSelect(object sender, EventArgs e)
        {
            /*Session["SessionId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId2"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId3"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId4"] = (sender as ASPxGridView).GetMasterRowKeyValue();
             */
        }



        protected void FileType_SelectedIndexChanged(object sender, EventArgs e)
        {
            /*if (string.IsNullOrEmpty(tbPrintId.Text))
            {
                return;
            }*/

            //var docPrint = new PRN_CPlan_Doc();
            //docPrint.cat_id.Value = Convert.ToInt32(tbPrintId.Text);
            //docPrint.CreateDocument();
            //dvReport.Report = docPrint;
            //dvReport.DataBind();

            
            /*
            GetdataSave_mPackingMonth = Convert.ToInt16(PackingMonth.SelectedItem.Value);
            GetdataSave_mModelId = Convert.ToInt16(ModelId.SelectedItem.Value);
            GetdataSave_mVarianId = Convert.ToInt16(VarianId.SelectedItem.Value);

            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            conn.Open(); */
            
        }


    }
}