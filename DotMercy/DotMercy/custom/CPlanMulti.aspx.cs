using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

using System.IO;
using System.Data.OleDb;

using System.Data.SqlClient;


namespace DotMercy.custom
{
    public partial class CPlanMulti : System.Web.UI.Page
    {

        public static int PublicMasterId = 0;
        public static int PublicStationId = 0;
        public static string PublicDetailId = "";


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
            grid.DataBind();
            //Session["sessiionRICId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void PlanGrid_DataSelect(object sender, EventArgs e)
        {
            Session["SessionId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId2"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId3"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId4"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId5"] = (sender as ASPxGridView).GetMasterRowKeyValue();

            PublicMasterId = Convert.ToInt32(Session["SessionId"]);
            //Session["SessionId4"]=grid.GetRowValues(index, 'StationId');
            // .GetMasterRowKeyValue();
        }

        protected void PlanGrid_DataSelect2(object sender, EventArgs e)
        {
            Session["SessionId4"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            PublicStationId = Convert.ToInt32(Session["SessionId4"]);
            //PublicDetailId = Convert.ToString((sender as ASPxGridView).GetRowValues(0));
            //PublicDetailId = Convert.ToString((sender as ASPxGridView).GetMasterRowKeyValue());
            //PublicDetailId = Convert.ToString(grid.GetRowValues(0));

            //PublicDetailId = Convert.ToString(ordersGridView.GetMasterRowKeyValue());
            //PublicDetailId = ordersGridView.GetSelectedFieldValues(0);
            //ASPxGridView grid2 = sender as ASPxGridView;
            //List<object> objects = ordersGridView.GetSelectedFieldValues("Id");
                                    
        }

        protected void PlanGrid_DataSelect3(object sender, EventArgs e)
        {

            Session["SessionId5"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            //string wwwwwww = Session["SessionId5"].ToString();
        }

        protected void ASPxUploadControl1_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            e.CallbackData = this.SavePostedFile(e.UploadedFile);
            string param = Page.Request.Form["hiddenField"];
            
        }

        string SavePostedFile(UploadedFile uploadedFile)
        {
            //// return if File IS NOT VALID
            if (!uploadedFile.IsValid) return String.Empty;


            //=========cek folder
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            conn.Open();

            //---get data name Station            
            string StationName = "";
            string sqlST = string.Empty;
            sqlST = "select StationName from Stations where Id=" + PublicStationId + " ";
            SqlCommand selectST = new SqlCommand(sqlST, conn);
            selectST.CommandTimeout = 0;
            SqlDataReader RDST = selectST.ExecuteReader();

            while (RDST.Read())
            {
                StationName = Convert.ToString(RDST["StationName"]);                
            }
            RDST.Close();


            //----get id PM, ModelId, VarianId            
            string sqlCP = string.Empty;
            sqlCP = "select PackingMonthId, ModelId, VarianId from ControlPlan where Id=" + PublicMasterId + " ";
            SqlCommand selectCP = new SqlCommand(sqlCP, conn);
            selectCP.CommandTimeout = 0;
            SqlDataReader RDCP = selectCP.ExecuteReader();

            while (RDCP.Read())
            {
                GetdataSave_mVarianId = Convert.ToInt32(RDCP["PackingMonthId"]);
                GetdataSave_mModelId = Convert.ToInt32(RDCP["ModelId"]);
                GetdataSave_mPackingMonth = Convert.ToInt32(RDCP["VarianId"]);                
            }
            RDCP.Close();

            //---get data name Packing Month            
            string sqlPM = string.Empty;
            sqlPM = "select PackingMth from PackingMonths where Id=" + GetdataSave_mPackingMonth + " ";
            SqlCommand selectPM = new SqlCommand(sqlPM, conn);
            selectPM.CommandTimeout = 0;
            SqlDataReader RDPM = selectPM.ExecuteReader();

            while (RDPM.Read())
            {
                GetdataSave_mPackingMonthName = Convert.ToString(RDPM["PackingMth"]);
            }
            RDPM.Close();

            //---get data name Model            
            string sqlMD = string.Empty;
            sqlMD = "select VarianName from Varians where Id=" + GetdataSave_mModelId + " ";
            SqlCommand selectMD = new SqlCommand(sqlMD, conn);
            selectMD.CommandTimeout = 0;
            SqlDataReader RDMD = selectMD.ExecuteReader();

            while (RDMD.Read())
            {
                GetdataSave_mModelName = Convert.ToString(RDMD["VarianName"]);
            }
            RDMD.Close();


            //---get data name Varian
            string sqlVR = string.Empty;
            sqlVR = "select ModelVarian from VarianDetails where Id=" + GetdataSave_mVarianId + " ";
            SqlCommand selectVR = new SqlCommand(sqlVR, conn);
            selectVR.CommandTimeout = 0;
            SqlDataReader RDVR = selectVR.ExecuteReader();

            while (RDVR.Read())
            {
                GetdataSave_mVarianName = Convert.ToString(RDVR["ModelVarian"]);
            }
            RDVR.Close();

            //---get data name File Type
            string sql = string.Empty;
            sql = "select Name from FileType where Id=" + GetdataSave_mFileType + " ";
            SqlCommand select = new SqlCommand(sql, conn);
            select.CommandTimeout = 0;
            SqlDataReader RD = select.ExecuteReader();

            while (RD.Read())
            {
                GetdataSave_mFileTypeName = Convert.ToString(RD["Name"]);
            }
            RD.Close();


            string path = "~/custom/FileUpload/" + GetdataSave_mPackingMonthName + "/" 
                        + GetdataSave_mModelName + "/" + GetdataSave_mVarianName + "/" 
                        + StationName;
            if (!Directory.Exists(Server.MapPath(path)))
            {
                Directory.CreateDirectory(Server.MapPath(path));
            }

            

            String UploadDir = path; // +"/" + uploadedFile; // "../custom/FileUpload/";


            FileInfo fileInfo = new FileInfo(uploadedFile.FileName);
            String fileNameOri = uploadedFile.FileName.ToString(); //.Replace(" ", "_");
            String ext = System.IO.Path.GetExtension(uploadedFile.FileName);
            String fileType = uploadedFile.ContentType.ToString();
            if ((fileNameOri.Length - ext.Length) > 16)
            {
                fileNameOri = fileNameOri.Substring(0, 16).ToLower() + ext;
            }

            //String fileName = String.Format("PL_{0:yyMMddHHmm}_{1}", DateTime.Now, fileNameOri.ToLower());

            String fileName = fileNameOri;

            String resFileName = "";
            if (!File.Exists(UploadDir + '/' + fileName))
            {
                resFileName = Server.MapPath(UploadDir + '/' + fileName);
                uploadedFile.SaveAs(resFileName);
            }

            String fileLabel = fileInfo.Name;

            double fileLength = Convert.ToDouble(uploadedFile.ContentLength / 1024); // kilobyte
            //int JumSampUji = (Session[SNAME_LIST_DETUJI] as List<DetailUjiDS>).Count;
            String ret = ""; // String.Format("{0}|{1}|{2}|{3}", fileName, fileLength, fileType, JumSampUji);
            return ret;
        }


        protected void ASPxUploadControl1_FileUploadComplete2(object sender, FileUploadCompleteEventArgs e)
        {
            e.CallbackData = this.SavePostedFile2(e.UploadedFile);
            string param = Page.Request.Form["hiddenField2"];
        }

        string SavePostedFile2(UploadedFile uploadedFile)
        {
            //// return if File IS NOT VALID
            if (!uploadedFile.IsValid) return String.Empty;


            //=========cek folder
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            conn.Open();

            //---get data name Station            
            string StationName = "";
            string sqlMD = string.Empty;
            sqlMD = "select StationName from Stations where Id=" + PublicStationId + " ";
            SqlCommand selectMD = new SqlCommand(sqlMD, conn);
            selectMD.CommandTimeout = 0;
            SqlDataReader RDMD = selectMD.ExecuteReader();

            while (RDMD.Read())
            {
                StationName = Convert.ToString(RDMD["StationName"]);
            }
            RDMD.Close();

            string path = "~/custom/FileUpload/" + StationName;
            if (!Directory.Exists(Server.MapPath(path)))
            {
                Directory.CreateDirectory(Server.MapPath(path));
            }

            String UploadDir = path; // +"/" + uploadedFile; // "../custom/FileUpload/";


            FileInfo fileInfo = new FileInfo(uploadedFile.FileName);
            String fileNameOri = uploadedFile.FileName.ToString(); //.Replace(" ", "_");
            String ext = System.IO.Path.GetExtension(uploadedFile.FileName);
            String fileType = uploadedFile.ContentType.ToString();
            if ((fileNameOri.Length - ext.Length) > 16)
            {
                fileNameOri = fileNameOri.Substring(0, 16).ToLower() + ext;
            }

            //String fileName = String.Format("PL_{0:yyMMddHHmm}_{1}", DateTime.Now, fileNameOri.ToLower());

            String fileName = fileNameOri;

            String resFileName = "";
            if (!File.Exists(UploadDir + '/' + fileName))
            {
                resFileName = Server.MapPath(UploadDir + '/' + fileName);
                uploadedFile.SaveAs(resFileName);
            }

            String fileLabel = fileInfo.Name;

            double fileLength = Convert.ToDouble(uploadedFile.ContentLength / 1024); // kilobyte
            //int JumSampUji = (Session[SNAME_LIST_DETUJI] as List<DetailUjiDS>).Count;
            String ret = ""; // String.Format("{0}|{1}|{2}|{3}", fileName, fileLength, fileType, JumSampUji);
            return ret;
        }

        

    }
}