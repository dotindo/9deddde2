using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.DataAccess;

namespace DotMercy.custom.Report
{
    public partial class ReportViewer_ : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxDocumentViewer1.Report = CrearReporte();
        }
        XtraReport1 CrearReporte()
        {
            XtraReport1 report = new XtraReport1();
            if (Convert.ToInt32(report.parameter1.Value) > 0)
            {
                report.Parameters[0].Value = report.parameter1.Value;
                report.Parameters[1].Value = report.parameter2.Value;
                report.Parameters[2].Value = report.parameter3.Value;
                report.CreateDocument(true);
            }         
            return report;
        }

    }
}