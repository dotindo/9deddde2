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

namespace DotMercy.custom
{
    public partial class PackingList : System.Web.UI.Page
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

                int paramPackingMonth = 0;
                int paramModel = 0;
                int paramVarian = 0;
                int paramFileType = 0;

                paramPackingMonth = Convert.ToInt32(Request.QueryString["vpm"]);
                paramModel = Convert.ToInt32(Request.QueryString["model"]);
                paramVarian = Convert.ToInt32(Request.QueryString["variant"]);
                paramFileType = Convert.ToInt32(Request.QueryString["type"]);

                PackingMonth.Value = paramPackingMonth;
                ModelId.Value = paramModel;
                VarianId.Value = paramVarian;
                FileType.Value = paramFileType;
            }
        }
        protected void PlanGrid_DataSelect(object sender, EventArgs e)
        {
            Session["SessionId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId2"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId3"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionId4"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }


        protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            //RemoveFileWithDelay(e.UploadedFile.FileNameInStorage, 5);

            //string name = e.UploadedFile.FileName;
            //string url = GetImageUrl(e.UploadedFile.FileNameInStorage);
            //long sizeInKilobytes = e.UploadedFile.ContentLength / 1024;
            //string sizeText = sizeInKilobytes.ToString() + " KB";
            //e.CallbackData = name + "|" + url + "|" + sizeText;
        }

        /*---------------------START IMPORT FILE----------------------------*/
        protected void UcDataUji_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
        {
            try
            {
                e.CallbackData = this.SavePostedFile(e.UploadedFile);

                int mPackingMonthId = GetdataSave_mPackingMonth;
                int mModelId = GetdataSave_mModelId;
                int mVarianId = GetdataSave_mVarianId;
                int mFileType = GetdataSave_mFileType;

                if (GetdataSave_mFileTypeName == "Packing List")
                {
                    Process_SaveMaster(mModelId, mVarianId, mPackingMonthId, mFileType);
                }

                if (GetdataSave_mFileTypeName == "Technical Alteration")
                {
                    Process_SaveMaster_Alteration(mModelId, mVarianId, mPackingMonthId, mFileType);
                }

                if (GetdataSave_mFileTypeName == "Dialog")
                {
                    Process_SaveMaster_Dialog(mModelId, mVarianId, mPackingMonthId, mFileType);
                }

                if (GetdataSave_mFileTypeName == "Vehicle Order")
                {
                    Process_SaveMaster_VO(mModelId, mVarianId, mPackingMonthId, mFileType);
                }
                if (GetdataSave_mFileTypeName == "Production Sequence")
                {
                    Process_SaveMaster_PS(mModelId, mVarianId, mPackingMonthId, mFileType);
                }

                if (GetdataSave_mFileTypeName == "Trolley List")
                {
                    Process_SaveMaster_Trolley(mModelId, mVarianId, mPackingMonthId, mFileType);
                }

            }
            catch (Exception ex)
            {
                e.IsValid = false;
                e.ErrorText = ex.Message;
            }
        }

        string SavePostedFile(UploadedFile uploadedFile)
        {
            //// return if File IS NOT VALID
            if (!uploadedFile.IsValid) return String.Empty;


            //=========cek folder Packing Month
            string path = "~/custom/FileUpload/" + GetdataSave_mPackingMonthName;
            if (!Directory.Exists(Server.MapPath(path)))
            {
                Directory.CreateDirectory(Server.MapPath(path));
            }

            //=========cek folder Model
            string pathModel = path + "/" + GetdataSave_mModelName;
            if (!Directory.Exists(Server.MapPath(pathModel)))
            {
                Directory.CreateDirectory(Server.MapPath(pathModel));
            }

            //=========cek folder Varian
            string pathVarian = pathModel + "/" + GetdataSave_mVarianName;
            if (!Directory.Exists(Server.MapPath(pathVarian)))
            {
                Directory.CreateDirectory(Server.MapPath(pathVarian));
            }

            String UploadDir = pathVarian + "/"; // "../custom/FileUpload/";


            FileInfo fileInfo = new FileInfo(uploadedFile.FileName);
            String fileNameOri = uploadedFile.FileName.ToString().Replace(" ", "_");
            String ext = System.IO.Path.GetExtension(uploadedFile.FileName);
            String fileType = uploadedFile.ContentType.ToString();
            if ((fileNameOri.Length - ext.Length) > 16)
            {
                fileNameOri = fileNameOri.Substring(0, 16).ToLower() + ext;
            }

            //String fileName = String.Format("PL_{0:yyMMddHHmm}_{1}", DateTime.Now, fileNameOri.ToLower());

            String fileName = fileNameOri;

            String resFileName = "";
            if (!File.Exists(UploadDir + fileName))
            {
                resFileName = Server.MapPath(UploadDir + fileName);
                uploadedFile.SaveAs(resFileName);
            }

            //type file check
            if (GetdataSave_mFileTypeName == "Packing List")
            {
                _ProcessExcel(ext, resFileName);
            }

            if (GetdataSave_mFileTypeName == "Technical Alteration")
            {
                _ProcessExcel_alteration(ext, resFileName);
            }

            if (GetdataSave_mFileTypeName == "Dialog")
            {
                _ProcessExcel_dialog(ext, resFileName);
            }

            if (GetdataSave_mFileTypeName == "Vehicle Order")
            {
                _ProcessExcel_VO(ext, resFileName);
            }

            if (GetdataSave_mFileTypeName == "Production Sequence")
            {
                _ProcessExcel_PS(ext, resFileName);
            }

            if (GetdataSave_mFileTypeName == "Trolley List")
            {
                _ProcessExcel_Trolley(ext, resFileName);
            }

            String fileLabel = fileInfo.Name;

            double fileLength = Convert.ToDouble(uploadedFile.ContentLength / 1024); // kilobyte
            //int JumSampUji = (Session[SNAME_LIST_DETUJI] as List<DetailUjiDS>).Count;
            String ret = ""; // String.Format("{0}|{1}|{2}|{3}", fileName, fileLength, fileType, JumSampUji);
            return ret;
        }


        private void _ProcessExcel(string ext, string fileXls)
        {
            System.Data.DataTable dt = null;

            string connString = "";
            string strFileType = ext;
            string path = fileXls;
            //Connection String to Excel Workbook
            if (strFileType.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strFileType.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            string query = "";  //"SELECT * FROM [CAT$]";
            OleDbConnection connExcel = new OleDbConnection(connString);
            if (connExcel.State == ConnectionState.Closed)
                connExcel.Open();

            //---------get sheet name
            int x = 0;
            dt = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dt.Rows.Count];

            foreach (DataRow row in dt.Rows)
            {
                if (x == 0)
                {
                    excelSheets[x] = row["TABLE_NAME"].ToString();
                    query = "SELECT * FROM [" + excelSheets[x].Replace("'", "") + "]";
                }
                x++;
            }
            //---------------

            OleDbCommand cmdExcel = new OleDbCommand(query, connExcel);
            OleDbDataAdapter daExcel = new OleDbDataAdapter(cmdExcel);
            DataSet dsExcel = new DataSet();

            daExcel.Fill(dsExcel);

            OleDbDataReader rdrExcel;
            rdrExcel = cmdExcel.ExecuteReader();

            int data_Detail = 0;
            int i = 0;
            int j = 0;
            string strValue = "";
            string strCaption = "";

            Import_Delete();

            while (rdrExcel.Read())
            {
                string sqlvalues2 = "";
                string exlcaption = "";

                if (data_Detail >= 0)
                {

                    strValue = "";
                    strCaption = "";

                    //for (i = 0; i < rdrExcel.FieldCount; i++)
                    for (i = 0; i < 63; i++)
                    {

                        sqlvalues2 = rdrExcel[i].ToString();
                        exlcaption = rdrExcel.GetName(i);

                        //if (sqlvalues2 != "")
                        //{
                        strValue = sqlvalues2 + "|" + strValue;

                        strCaption = exlcaption + "|" + strCaption;
                        //}

                    }

                }

                data_Detail++;

                if (strValue != "")
                {
                    j++;
                    Import_Proses(strValue, j);
                    //Import_Proses(strValue, strCaption, j);
                }
            }

            rdrExcel.Close();

        }


        private void _ProcessExcel_alteration(string ext, string fileXls)
        {
            System.Data.DataTable dt = null;

            string connString = "";
            string strFileType = ext;
            string path = fileXls;
            //Connection String to Excel Workbook
            if (strFileType.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strFileType.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            string query = "";  //"SELECT * FROM [CAT$]";
            OleDbConnection connExcel = new OleDbConnection(connString);
            if (connExcel.State == ConnectionState.Closed)
                connExcel.Open();

            //---------get sheet name
            int x = 0;
            dt = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dt.Rows.Count];

            foreach (DataRow row in dt.Rows)
            {
                if (x == 0)
                {
                    excelSheets[x] = row["TABLE_NAME"].ToString();
                    query = "SELECT * FROM [" + excelSheets[x].Replace("'", "") + "]";
                }
                x++;
            }
            //---------------

            OleDbCommand cmdExcel = new OleDbCommand(query, connExcel);
            OleDbDataAdapter daExcel = new OleDbDataAdapter(cmdExcel);
            DataSet dsExcel = new DataSet();

            daExcel.Fill(dsExcel);

            OleDbDataReader rdrExcel;
            rdrExcel = cmdExcel.ExecuteReader();

            int data_Detail = 0;
            int i = 0;
            int j = 0;
            string strValue = "";
            string strCaption = "";

            Import_Delete();

            while (rdrExcel.Read())
            {
                string sqlvalues2 = "";
                string exlcaption = "";

                if (data_Detail >= 0)
                {

                    strValue = "";
                    strCaption = "";

                    //for (i = 0; i < rdrExcel.FieldCount; i++)
                    for (i = 0; i < 14; i++)
                    {

                        sqlvalues2 = rdrExcel[i].ToString();
                        exlcaption = rdrExcel.GetName(i);

                        //if (sqlvalues2 != "")
                        //{
                        strValue = sqlvalues2 + "|" + strValue;

                        strCaption = exlcaption + "|" + strCaption;
                        //}

                    }

                }

                data_Detail++;

                if (strValue != "")
                {
                    j++;
                    Import_Proses_alteration(strValue, j);
                    //Import_Proses(strValue, strCaption, j);
                }
            }

            rdrExcel.Close();

        }


        private void _ProcessExcel_dialog(string ext, string fileXls)
        {
            System.Data.DataTable dt = null;

            string connString = "";
            string strFileType = ext;
            string path = fileXls;
            //Connection String to Excel Workbook
            if (strFileType.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strFileType.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            string query = "";  //"SELECT * FROM [CAT$]";
            OleDbConnection connExcel = new OleDbConnection(connString);
            if (connExcel.State == ConnectionState.Closed)
                connExcel.Open();

            //---------get sheet name
            int x = 0;
            dt = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dt.Rows.Count];

            foreach (DataRow row in dt.Rows)
            {
                if (x == 0)
                {
                    excelSheets[x] = row["TABLE_NAME"].ToString();
                    query = "SELECT * FROM [" + excelSheets[x].Replace("'", "") + "]";
                }
                x++;
            }
            //---------------

            OleDbCommand cmdExcel = new OleDbCommand(query, connExcel);
            OleDbDataAdapter daExcel = new OleDbDataAdapter(cmdExcel);
            DataSet dsExcel = new DataSet();

            daExcel.Fill(dsExcel);

            OleDbDataReader rdrExcel;
            rdrExcel = cmdExcel.ExecuteReader();

            int data_Detail = 0;
            int i = 0;
            int j = 0;
            string strValue = "";
            string strCaption = "";

            Import_Delete();

            while (rdrExcel.Read())
            {
                string sqlvalues2 = "";
                string exlcaption = "";

                if (data_Detail >= 0)
                {

                    strValue = "";
                    strCaption = "";

                    //for (i = 0; i < rdrExcel.FieldCount; i++)
                    for (i = 0; i < 20; i++)
                    {

                        sqlvalues2 = rdrExcel[i].ToString();
                        exlcaption = rdrExcel.GetName(i);

                        //if (sqlvalues2 != "")
                        //{
                        strValue = sqlvalues2 + "|" + strValue;

                        strCaption = exlcaption + "|" + strCaption;
                        //}

                    }

                }

                data_Detail++;

                if (strValue != "")
                {
                    j++;
                    Import_Proses_dialog(strValue, j);
                    //Import_Proses(strValue, strCaption, j);
                }
            }

            rdrExcel.Close();

        }


        private void _ProcessExcel_VO(string ext, string fileXls)
        {
            System.Data.DataTable dt = null;

            string connString = "";
            string strFileType = ext;
            string path = fileXls;
            //Connection String to Excel Workbook
            if (strFileType.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strFileType.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            string query = "";  //"SELECT * FROM [CAT$]";
            OleDbConnection connExcel = new OleDbConnection(connString);
            if (connExcel.State == ConnectionState.Closed)
                connExcel.Open();

            //---------get sheet name
            int x = 0;
            dt = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dt.Rows.Count];

            foreach (DataRow row in dt.Rows)
            {
                if (x == 0)
                {
                    excelSheets[x] = row["TABLE_NAME"].ToString();
                    query = "SELECT * FROM [" + excelSheets[x].Replace("'", "") + "]";
                }
                x++;
            }
            //---------------

            OleDbCommand cmdExcel = new OleDbCommand(query, connExcel);
            OleDbDataAdapter daExcel = new OleDbDataAdapter(cmdExcel);
            DataSet dsExcel = new DataSet();

            daExcel.Fill(dsExcel);

            OleDbDataReader rdrExcel;
            rdrExcel = cmdExcel.ExecuteReader();

            int data_Detail = 0;
            int i = 0;
            int j = 0;
            string strValue = "";
            string strCaption = "";

            Import_Delete();

            while (rdrExcel.Read())
            {
                string sqlvalues2 = "";
                string exlcaption = "";

                if (data_Detail >= 0)
                {

                    strValue = "";
                    strCaption = "";

                    //for (i = 0; i < rdrExcel.FieldCount; i++)
                    for (i = 0; i < 16; i++)
                    {

                        sqlvalues2 = rdrExcel[i].ToString();
                        exlcaption = rdrExcel.GetName(i);

                        //if (sqlvalues2 != "")
                        //{
                        strValue = sqlvalues2 + "|" + strValue;

                        strCaption = exlcaption + "|" + strCaption;
                        //}

                    }

                }

                data_Detail++;

                if (strValue != "")
                {
                    j++;
                    Import_Proses_VO(strValue, j);
                    //Import_Proses(strValue, strCaption, j);
                }
            }

            rdrExcel.Close();

        }

        private void _ProcessExcel_PS(string ext, string fileXls)
        {
            System.Data.DataTable dt = null;

            string connString = "";
            string strFileType = ext;
            string path = fileXls;
            //Connection String to Excel Workbook
            if (strFileType.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strFileType.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }


            string query = "";  //"SELECT * FROM [CAT$]";
            OleDbConnection connExcel = new OleDbConnection(connString);
            if (connExcel.State == ConnectionState.Closed)
                connExcel.Open();

            //---------get sheet name
            int x = 0;
            dt = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dt.Rows.Count];

            foreach (DataRow row in dt.Rows)
            {
                if (x == 0)
                {
                    excelSheets[x] = row["TABLE_NAME"].ToString();
                    query = "SELECT * FROM [" + excelSheets[x].Replace("'", "") + "]";
                }
                x++;
            }
            //---------------

            OleDbCommand cmdExcel = new OleDbCommand(query, connExcel);
            OleDbDataAdapter daExcel = new OleDbDataAdapter(cmdExcel);
            DataSet dsExcel = new DataSet();

            daExcel.Fill(dsExcel);

            OleDbDataReader rdrExcel;
            rdrExcel = cmdExcel.ExecuteReader();

            int data_Detail = 0;
            int i = 0;
            int j = 0;
            string strValue = "";
            string strCaption = "";

            Import_Delete();

            while (rdrExcel.Read())
            {
                string sqlvalues2 = "";
                string exlcaption = "";

                if (data_Detail >= 0)
                {

                    strValue = "";
                    strCaption = "";

                    //for (i = 0; i < rdrExcel.FieldCount; i++)
                    for (i = 0; i < 16; i++)
                    {

                        sqlvalues2 = rdrExcel[i].ToString();
                        exlcaption = rdrExcel.GetName(i);

                        //if (sqlvalues2 != "")
                        //{
                        strValue = sqlvalues2 + "|" + strValue;

                        strCaption = exlcaption + "|" + strCaption;
                        //}

                    }

                }

                data_Detail++;

                if (sqlvalues2 != "")
                {
                    j++;
                    
                        Import_Proses_PS(strValue, j);
                        //Import_Proses(strValue, strCaption, j);
                                                                            
                }
            }

            rdrExcel.Close();

        }

        private void _ProcessExcel_Trolley(string ext, string fileXls)
        {
            System.Data.DataTable dt = null;

            string connString = "";
            string strFileType = ext;
            string path = fileXls;
            //Connection String to Excel Workbook
            if (strFileType.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + path + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (strFileType.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }


            string query = "";  //"SELECT * FROM [CAT$]";
            OleDbConnection connExcel = new OleDbConnection(connString);
            if (connExcel.State == ConnectionState.Closed)
                connExcel.Open();

            //---------get sheet name
            int x = 0;
            dt = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dt.Rows.Count];

            foreach (DataRow row in dt.Rows)
            {
                if (x == 0)
                {
                    excelSheets[x] = row["TABLE_NAME"].ToString();
                    query = "SELECT * FROM [" + excelSheets[x].Replace("'", "") + "]";
                }
                x++;
            }
            //---------------

            OleDbCommand cmdExcel = new OleDbCommand(query, connExcel);
            OleDbDataAdapter daExcel = new OleDbDataAdapter(cmdExcel);
            DataSet dsExcel = new DataSet();

            daExcel.Fill(dsExcel);

            OleDbDataReader rdrExcel;
            rdrExcel = cmdExcel.ExecuteReader();

            int data_Detail = 0;
            int i = 0;
            int j = 0;
            string strValue = "";
            string strCaption = "";

            Import_Delete();

            while (rdrExcel.Read())
            {
                string sqlvalues2 = "";
                string exlcaption = "";

                if (data_Detail >= 0)
                {

                    strValue = "";
                    strCaption = "";

                    //for (i = 0; i < rdrExcel.FieldCount; i++)
                    for (i = 0; i < 18; i++)
                    {

                        sqlvalues2 = rdrExcel[i].ToString();
                        exlcaption = rdrExcel.GetName(i);

                        //if (sqlvalues2 != "")
                        //{
                        strValue = sqlvalues2 + "|" + strValue;

                        strCaption = exlcaption + "|" + strCaption;
                        //}

                    }

                }

                data_Detail++;

                if (sqlvalues2 != "Component")
                {
                    j++;
                    if (j==1122)
                    {
                        sqlvalues2 = "";
                    }
                    Import_Proses_Trolley(strValue, j);
                    //Import_Proses(strValue, strCaption, j);
                }
            }

            rdrExcel.Close();

        }



        private void Import_Delete()
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {

                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;
                cmd.CommandText = "delete PackingListDetails_tmp; delete AlterationDetails_tmp; delete DialogDetails_tmp; delete VehicleOrderDetails_tmp;";
                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }

            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        private void Import_Proses(string strValue, int __no)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                string[] strAll = strValue.Split('|');

                int detail_id = Convert.ToInt32(__no);

                if (strAll[62] == "") return;

                int Identification = Convert.ToInt16(strAll[62]);
                string PackingCompany =  Convert.ToString(strAll[61]).Trim();
                string PlantCode = Convert.ToString(strAll[60]).Trim();
                int Year = Convert.ToInt16(strAll[59]);
                int Month = Convert.ToInt16(strAll[58]);
                string Consignment = Convert.ToString(strAll[57]).Trim();
                string CountryCode = Convert.ToString(strAll[56]).Trim();
                string CountryDescription = Convert.ToString(strAll[55]).Trim();
                string Model = Convert.ToString(strAll[54]).Trim();
                string ModelDescription = Convert.ToString(strAll[53]).Trim();
                string Productionnofrom = Convert.ToString(strAll[52]).Trim();

                string Productionnoto = Convert.ToString(strAll[51]).Trim();
                string InteriorColour = Convert.ToString(strAll[50]).Trim();
                string OutsideColour = Convert.ToString(strAll[49]).Trim();
                string Indication = Convert.ToString(strAll[48]).Trim();
                string DateOfDispatch = Convert.ToString(strAll[47]).Trim();
                string CommisionNoYear = Convert.ToString(strAll[46]).Trim();
                string CommisionNoCountry = Convert.ToString(strAll[45]).Trim();
                string CommisionFrom = Convert.ToString(strAll[44]).Trim();
                string CommisionTo = Convert.ToString(strAll[43]).Trim();
                string NumberOfCar = Convert.ToString(strAll[42]).Trim();
                string MainOrSmall = Convert.ToString(strAll[41]).Trim();
                string PartNoType = Convert.ToString(strAll[40]).Trim();
                string PartNoHkb = Convert.ToString(strAll[39]).Trim();
                string PartNumber = Convert.ToString(strAll[38]).Trim();
                string PartNoKb = Convert.ToString(strAll[37]).Trim();
                string Es1 = Convert.ToString(strAll[36]).Trim();
                string Es2 = Convert.ToString(strAll[35]).Trim();
                string IndexSmallParts = Convert.ToString(strAll[34]).Trim();
                string PDescriptionGerman = Convert.ToString(strAll[33]).Trim();
                string PDescriptionEnglish = Convert.ToString(strAll[32]).Trim();
                string SignOfQty = Convert.ToString(strAll[31]).Trim();
                
                //string QuantityN = Convert.ToString(strAll[30]).Trim().Replace(",",".");
                string[] QuantityN_Split = Convert.ToString(strAll[30]).Trim().Split(',');
                int QuantityN = Convert.ToInt32(QuantityN_Split[0])/6;
                
                string UnitOfMeasure = Convert.ToString(strAll[29]).Trim();
                string PackageIdentification = Convert.ToString(strAll[28]).Trim();
                string AssistanMaterial = Convert.ToString(strAll[27]).Trim();
                string FzNo = Convert.ToString(strAll[26]).Trim();
                string WeightPackage = Convert.ToString(strAll[25]).Trim();
                string VolPackage = "0"; // Convert.ToString(strAll[24]).Trim().Replace(",", ".");
                string SingleOrMultipart = Convert.ToString(strAll[23]).Trim();
                string SignofVPHM = Convert.ToString(strAll[22]).Trim();
                string QtyVPHM = "0"; // Convert.ToString(strAll[21]);
                string Info = Convert.ToString(strAll[20]).Trim();
                string Remark = Convert.ToString(strAll[19]).Replace("'", "''").Trim();
                string ColourDescriptionGer = Convert.ToString(strAll[18]).Trim();
                string DolourDescriptionEng = Convert.ToString(strAll[17]).Trim();
                string AssemblyStation = Convert.ToString(strAll[16]).Trim();
                string PosWithinPackage = Convert.ToString(strAll[15]).Trim();
                string AppliModel = Convert.ToString(strAll[14]).Trim();
                string AppliAA = Convert.ToString(strAll[13]).Trim();
                string KGU = Convert.ToString(strAll[12]).Trim();
                string TU = Convert.ToString(strAll[11]).Trim();
                string POS = Convert.ToString(strAll[10]).Trim();
                string AppliTxtGer = Convert.ToString(strAll[9]).Trim();
                string AppliTxtEng = Convert.ToString(strAll[8]).Trim();
                string Packer = Convert.ToString(strAll[7]).Trim();
                string Options = Convert.ToString(strAll[6]).Trim();
                string Lot = Convert.ToString(strAll[5]).Trim();
                string Counter1 = Convert.ToString(strAll[4]).Trim();
                string Counter2 = Convert.ToString(strAll[3]).Trim();
                string ConsigneeKey = Convert.ToString(strAll[2]).Trim();
                string EX33Equalization = Convert.ToString(strAll[1]).Trim();
                string PartNo = Convert.ToString(strAll[0]).Trim();

                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                
                cmd.CommandText = "insert into PackingListDetails_tmp (Id, Identification, PackingCompany, PlantCode, Year, Month, Consignment, CountryCode, CountryDescription, Model, ModelDescription, " +
                                    " Productionnofrom, " +
                                    " Productionnoto, InteriorColour, OutsideColour, Indication, DateOfDispatch, CommisionNoYear, CommisionNoCountry, CommisionFrom, " +
                                    " CommisionTo, NumberOfCar, MainOrSmall, PartNoType, PartNoHkb, PartNumber, PartNoKb, Es1, Es2, IndexSmallParts, PDescriptionGerman, PDescriptionEnglish, " +
                                    " SignOfQty, QuantityN, UnitOfMeasure, PackageIdentification, AssistanMaterial, FzNo, WeightPackage, VolPackage, SingleOrMultipart, SignofVPHM, QtyVPHM, Info, " +
                                    " Remark, ColourDescriptionGer, DolourDescriptionEng, AssemblyStation, PosWithinPackage, AppliModel, AppliAA, KGU, TU, POS, AppliTxtGer, AppliTxtEng, Packer, " +
                                    " Options, Lot, Counter1, Counter2, ConsigneeKey, EX33Equalization, PartNo) " +
                                    " values (" + detail_id + "," + Identification + ", '" + PackingCompany + "','" + PlantCode + "', " +
                                    " " + Year + "," + Month + ",'" + Consignment + "','" + CountryCode + "','" + CountryDescription + "'," +
                                    " '" + Model + "','" + ModelDescription + "','" + Productionnofrom + "', " +
                                    " '" + Productionnoto + "','" + InteriorColour + "','" + OutsideColour + "','" + Indication + "','" + DateOfDispatch + "'," + Convert.ToInt32(CommisionNoYear) + "," + Convert.ToInt32(CommisionNoCountry) + "," + Convert.ToInt32(CommisionFrom) + ", " +
                                    " " + Convert.ToInt32(CommisionTo) + ",'" + NumberOfCar + "','" + MainOrSmall + "'," + Convert.ToInt32(PartNoType) + ",'" + PartNoHkb + "','" + PartNumber + "','" + PartNoKb + "','" + Es1 + "','" + Es2 + "','" + IndexSmallParts + "','" + PDescriptionGerman + "','" + PDescriptionEnglish + "', " +
                                    " '" + SignOfQty + "'," + Convert.ToInt32(QuantityN) + ",'" + UnitOfMeasure + "','" + PackageIdentification + "','" + AssistanMaterial + "','" + FzNo + "'," + Convert.ToDouble(WeightPackage) + "," + Convert.ToDouble(VolPackage) + ",'" + SingleOrMultipart + "','" + SignofVPHM + "'," + Convert.ToInt32(QtyVPHM) + ",'" + Info + "', " +
                                    " '" + Remark + "','" + ColourDescriptionGer + "','" + DolourDescriptionEng + "','" + AssemblyStation + "','" + PosWithinPackage + "','" + AppliModel + "','" + AppliAA + "','" + KGU + "','" + TU + "','" + POS + "','" + AppliTxtGer + "','" + AppliTxtEng + "','" + Packer + "', " +
                                    " '" + Options + "','" + Lot + "','" + Counter1 + "','" + Counter2 + "','" + ConsigneeKey + "','" + EX33Equalization + "','" + PartNo + "')";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());



                //insert master
                //cmd.CommandText = "";


                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }


                /*else
                {
                    // if success, move file;
                    moveFileSurvTotxtDir(segmentId);
                }*/

                cmd.Parameters.Clear();

                

            }

            
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }


        private void Import_Proses_alteration(string strValue, int __no)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                string[] strAll = strValue.Split('|');

                int detail_id = Convert.ToInt32(__no);

                string VpMonat = Convert.ToString(strAll[13]);
                string Pem = Convert.ToString(strAll[12]);
                string PemModelLine = Convert.ToString(strAll[11]);
                string PartList = Convert.ToString(strAll[10]);
                string Aa = Convert.ToString(strAll[9]);
                string Application = Convert.ToString(strAll[8]);
                string KennzAltNeu = Convert.ToString(strAll[7]);
                string PartNo = Convert.ToString(strAll[6]);
                string Es1 = Convert.ToString(strAll[5]);
                string IndexNo = Convert.ToString(strAll[4]);
                string Description = Convert.ToString(strAll[3]);
                string Piece = Convert.ToString(strAll[2]).Replace(",",".");
                string Code = Convert.ToString(strAll[1]);
                string Remark = Convert.ToString(strAll[0]);

                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                if (Pem != "")
                {
                    cmd.CommandText = "insert into AlterationDetails_tmp (Id, VpMonat, Pem, PemModelLine, PartList, Aa, Application, KennzAltNeu, PartNo, Es1, " +
                                        " IndexNo, Description, Piece, Code, Remark ) " +
                                        " values (" + detail_id + "," + VpMonat + ", '" + Pem + "', '" + PemModelLine + "','" + PartList + "', " +
                                        " '" + Aa + "','" + Application + "','" + KennzAltNeu + "','" + PartNo + "','" + Es1 + "'," +
                                        " '" + IndexNo + "','" + Description + "'," + Convert.ToDouble(Piece) + ", '" + Code + "', '" + Remark + "')";

                    string exeMsg = Convert.ToString(cmd.ExecuteScalar());


                    //insert master
                    //cmd.CommandText = "";


                    //check error


                    if (!exeMsg.Trim().Equals(""))
                    {
                        //Logger.Error("Execution Query : " + exeMsg);
                        isError = true;
                        errMsg = exeMsg;
                    }




                    /*else
                    {
                        // if success, move file;
                        moveFileSurvTotxtDir(segmentId);
                    }*/

                    cmd.Parameters.Clear();
                }

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }


        private void Import_Proses_dialog(string strValue, int __no)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                string[] strAll = strValue.Split('|');

                int detail_id = Convert.ToInt32(__no);

                string SubModule = Convert.ToString(strAll[19]);
                string POS = Convert.ToString(strAll[18]);
                string PV = Convert.ToString(strAll[17]);
                string WW = Convert.ToString(strAll[16]);
                string AA = Convert.ToString(strAll[15]);
                string LK = Convert.ToString(strAll[14]);
                string SC = Convert.ToString(strAll[13]);
                string SP = Convert.ToString(strAll[12]);
                string ST = Convert.ToString(strAll[11]);
                string Part = Convert.ToString(strAll[10]);
                string ZB = Convert.ToString(strAll[9]);
                string Name_ = Convert.ToString(strAll[8]).Replace("'", "''");

                string Quantity = "";
                if (Convert.ToString(strAll[7]) == "")
                {
                    Quantity = "0";
                }
                else
                {
                    Quantity = Convert.ToString(strAll[7]);
                }

                string UQTY = Convert.ToString(strAll[6]);
                string CodeRule = Convert.ToString(strAll[5]);
                string R = Convert.ToString(strAll[4]);
                string BZA = Convert.ToString(strAll[3]);
                string DevBZA = Convert.ToString(strAll[2]);
                string PEMFrom = Convert.ToString(strAll[1]);
                string PEMTo = Convert.ToString(strAll[0]);

                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into DialogDetails_tmp (Id, SubModule, POS, PV, WW, AA, LK, SC, SP, ST, Part, ZB, Name, Quantity, UQTY, " +
                                    " CodeRule, R, BZA, DevBZA, PEMFrom, PEMTo ) " +
                                    " values (" + detail_id + ",'" + SubModule + "', '" + POS + "', '" + PV + "','" + WW + "', " +
                                    " '" + AA + "','" + LK + "','" + SC + "','" + SP + "','" + ST + "','" + Part + "'," +
                                    " '" + ZB + "','" + Name_ + "', " + Convert.ToDouble(Quantity) + ",'" + UQTY + "', '" + CodeRule + "', '" + R + "', " +
                                    " '" + BZA + "', '" + DevBZA + "', '" + PEMFrom + "', '" + PEMTo + "')";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //insert master
                //cmd.CommandText = "";


                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }
                /*else
                {
                    // if success, move file;
                    moveFileSurvTotxtDir(segmentId);
                }*/

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }


        private void Import_Proses_VO(string strValue, int __no)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                string[] strAll = strValue.Split('|');

                int detail_id = Convert.ToInt32(__no);

                string Plan = Convert.ToString(strAll[15]);
                string ProdNumber = Convert.ToString(strAll[14]);
                string OrderNumber = Convert.ToString(strAll[13]);
                string VehicleNumber = Convert.ToString(strAll[12]);
                string DeliveryNumber = Convert.ToString(strAll[11]);
                string VehicleType = Convert.ToString(strAll[10]);
                string EngineType = Convert.ToString(strAll[9]);
                string PlantDispathDate = Convert.ToString(strAll[8]);
                string Interior = Convert.ToString(strAll[7]);
                string Paint = Convert.ToString(strAll[6]);
                string Model = Convert.ToString(strAll[5]);
                string CountryName = Convert.ToString(strAll[4]);
                string EngineNumber = Convert.ToString(strAll[3]);
                string SampleDigit = Convert.ToString(strAll[2]);
                string NumberOfCode = Convert.ToString(strAll[1]);
                string Codes = Convert.ToString(strAll[0]);

                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into VehicleOrderDetails_tmp (Id, [Plan], ProdNumber, OrderNumber, VehicleNumber, DeliveryNumber, VehicleType, EngineType, " +
                                    " PlantDispathDate, Interior, Paint, Model, CountryName, EngineNumber, SampleDigit, NumberOfCode, Codes ) " +
                                    " values (" + detail_id + ",'" + Plan + "', '" + ProdNumber + "', '" + OrderNumber + "','" + VehicleNumber + "', " +
                                    " '" + DeliveryNumber + "','" + VehicleType + "','" + EngineType + "','" + PlantDispathDate + "','" + Interior + "','" + Paint + "'," +
                                    " '" + Model + "','" + CountryName + "', '" + EngineNumber + "','" + SampleDigit + "', '" + NumberOfCode + "', '" + Codes + "')";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //insert master
                //cmd.CommandText = "";


                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }
                /*else
                {
                    // if success, move file;
                    moveFileSurvTotxtDir(segmentId);
                }*/

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        private void Import_Proses_PS(string strValue, int __no)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                string[] strAll = strValue.Split('|');

                int detail_id = Convert.ToInt32(__no);

                string Type = Convert.ToString(strAll[14]).Trim();
                int CummFigr = Convert.ToInt16(strAll[13]);
                string MaterialNo = Convert.ToString(strAll[12]).Trim();
                string OrderNo = Convert.ToString(strAll[11]).Trim() ;
                string SerialNumber = Convert.ToString(strAll[10]).Trim();
                string DBProdSIFI = Convert.ToString(strAll[9]).Trim() + " " + Convert.ToString(strAll[8]).Trim();
                string ComnosNumber = Convert.ToString(strAll[7]).Trim();
                int Lot = Convert.ToInt16(strAll[6]);
                string EngnineNo = Convert.ToString(strAll[5]).Trim();
                int ColCode = Convert.ToInt16(strAll[4]);
                int IntCode = Convert.ToInt16(strAll[3]);
                string BomExpl = Convert.ToString(strAll[2]).Trim();
                string ChassisNoDCAG = Convert.ToString(strAll[1]).Trim();
                string FinishDate = Convert.ToString(strAll[0]).Trim();

               

                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;


                cmd.CommandText = "INSERT INTO mercedesdb.dbo.ProductionSequenceDetail_tmp " +
                                    "(Id,ProductionSequenceId,Type,CummFigr,MaterialNo,OrderNo,SerialNumber " +
                                    ",DBProdSIFI,ComnosNumber,Lot,EngnineNo,ColCode,IntCode,BomExpl,ChassisNoDCAG,FinishDate)  VALUES " +
                                    " (" + detail_id + ",0,'" + Type + "'," + CummFigr + ", " +
                                    "'" + MaterialNo + "','" + OrderNo + "','" + SerialNumber + "','" + DBProdSIFI + "','" + ComnosNumber + "'," +
                                    Lot + ",'" + EngnineNo + "'," + ColCode + "," + IntCode + ",'" + BomExpl + "','" + ChassisNoDCAG + "','" + FinishDate + "')";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());



                //insert master
                //cmd.CommandText = "";


                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }


                /*else
                {
                    // if success, move file;
                    moveFileSurvTotxtDir(segmentId);
                }*/

                cmd.Parameters.Clear();

            }


            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        private void Import_Proses_Trolley(string strValue, int __no)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                string[] strAll = strValue.Split('|');

                int detail_id = Convert.ToInt32(__no);

                string Model = Convert.ToString(strAll[16]).Trim();
                string Varian = Convert.ToString(strAll[15]);
                string Type = Convert.ToString(strAll[14]).Trim();
                string Station = Convert.ToString(strAll[13]).Trim();
                string Trolley = Convert.ToString(strAll[12]);
                string TrolleyType = Convert.ToString(strAll[11]).Trim();
                string TrolleyNo = Convert.ToString(strAll[10]).Trim();
                string Rack = Convert.ToString(strAll[9]).Trim();
                string Consignment = Convert.ToString(strAll[8]).Trim();
                string WI = Convert.ToString(strAll[7]).Trim();
                string Part = Convert.ToString(strAll[6]);
                string Desc = Convert.ToString(strAll[5]).Trim();
                int Quantity = 0;
                if (Convert.ToString(strAll[4]).Trim() == "") 
                {
                    Quantity = 0;
                }
                else
                {
                    Quantity = Convert.ToInt16(strAll[4]);
                }                
                string idx = Convert.ToString(strAll[3]);
                string Valid = Convert.ToString(strAll[2]).Trim();
                string Package = Convert.ToString(strAll[1]).Trim();
                string Component = Convert.ToString(strAll[0]).Trim();

                


                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;


                cmd.CommandText = "INSERT INTO mercedesdb..TrolleyListDetail_tmp " +
                                    "(Id,TrolleyListId,Model,Varian,Type,Station,Trolley,TrolleyType,TrolleyNo " +
                                    ",Rack,Consignment,WI,Part,[Desc],Quantity,idx,Valid,Package,Component)  VALUES " +
                                    " (" + detail_id + ",0,'" + Model + "','" + Varian + "','" + Type + "','" + Station + "','" + Trolley + "','" +
                                    TrolleyType + "','" + TrolleyNo + "','" + Rack + "','" + Consignment + "','" + WI + "','" +
                                    Part + "','" + Desc + "'," + Quantity + ",'" + idx + "','" + Valid + "','" + Package + "','" + Component + "')";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar()); 



                //insert master
                //cmd.CommandText = "";


                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }


                /*else
                {
                    // if success, move file;
                    moveFileSurvTotxtDir(segmentId);
                }*/

                cmd.Parameters.Clear();

            }


            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }


        //---------end import data excel-----------/\

        protected void btSave_Master(object sender, EventArgs e)
        {
            GetdataSave_mPackingMonth = Convert.ToInt16(PackingMonth.SelectedItem.Value);
            GetdataSave_mModelId = Convert.ToInt16(ModelId.SelectedItem.Value);
            GetdataSave_mVarianId = Convert.ToInt16(VarianId.SelectedItem.Value);

        }


        private void Process_SaveMaster(int intModelId, int intVarianId, int intPackingMonth, int intFileType)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into PackingLists (PackingMonth, ModelId, VarianId, FileType) " +
                                    " values (" + intPackingMonth + "," + intModelId + ", " + intVarianId + ", " + intFileType + ")";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }


        private void Process_SaveMaster_Alteration(int intModelId, int intVarianId, int intPackingMonth, int intFileType)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into Alterations (PackingMonth, ModelId, VarianId, FileType) " +
                                    " values (" + intPackingMonth + "," + intModelId + ", " + intVarianId + ", " + intFileType + ")";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        private void Process_SaveMaster_Dialog(int intModelId, int intVarianId, int intPackingMonth, int intFileType)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into Dialogs (PackingMonth, ModelId, VarianId, FileType) " +
                                    " values (" + intPackingMonth + "," + intModelId + ", " + intVarianId + ", " + intFileType + ")";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }


        private void Process_SaveMaster_VO(int intModelId, int intVarianId, int intPackingMonth, int intFileType)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into VehicleOrders (PackingMonth, ModelId, VarianId, FileType) " +
                                    " values (" + intPackingMonth + "," + intModelId + ", " + intVarianId + ", " + intFileType + ")";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        private void Process_SaveMaster_PS(int intModelId, int intVarianId, int intPackingMonth, int intFileType)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into ProductionSequence (PackingMonth, ModelId, VarianId, FileType) " +
                                    " values (" + intPackingMonth + "," + intModelId + ", " + intVarianId + ", " + intFileType + ")";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        private void Process_SaveMaster_Trolley(int intModelId, int intVarianId, int intPackingMonth, int intFileType)
        {
            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            SqlCommand cmd = new SqlCommand();

            bool isError = false;
            string errMsg = "";

            try
            {
                conn.Open();
                cmd.Connection = conn;
                cmd.CommandTimeout = 0;

                cmd.CommandText = "insert into TrolleyList (PackingMonth, ModelId, VarianId, FileType) " +
                                    " values (" + intPackingMonth + "," + intModelId + ", " + intVarianId + ", " + intFileType + ")";

                string exeMsg = Convert.ToString(cmd.ExecuteScalar());

                //check error
                if (!exeMsg.Trim().Equals(""))
                {
                    //Logger.Error("Execution Query : " + exeMsg);
                    isError = true;
                    errMsg = exeMsg;
                }

                cmd.Parameters.Clear();

            }
            catch (Exception ex)
            {
                //Logger.Error(ex.Message);
                isError = true;
                errMsg = ex.Message;
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }

            if (isError)
            {
                throw new InvalidOperationException(errMsg);
            }

        }

        protected void FileType_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetdataSave_mPackingMonth = Convert.ToInt16(PackingMonth.SelectedItem.Value);
            GetdataSave_mModelId = Convert.ToInt16(ModelId.SelectedItem.Value);
            GetdataSave_mVarianId = Convert.ToInt16(VarianId.SelectedItem.Value);
            GetdataSave_mFileType = Convert.ToInt16(FileType.SelectedItem.Value);

            SqlConnection conn = new SqlConnection(System.Web.Configuration.WebConfigurationManager.ConnectionStrings["AppDb"].ConnectionString);
            conn.Open();


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


        }

        protected void FileType_Callback(object sender, CallbackEventArgsBase e)
        {
            if (String.IsNullOrEmpty(e.Parameter))
                return;

            GetdataSave_mFileType = Convert.ToInt16(e.Parameter);
            //txtFileType.Value = Convert.ToInt16(e.Parameter);

        }


    }
}