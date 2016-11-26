using System;
using System.Drawing;
using System.Collections;
using System.ComponentModel;
using DevExpress.XtraReports.UI;
using DevExpress.DataAccess;
using System.Linq;


namespace DotMercy.custom.Report
{
    public partial class JCReport : DevExpress.XtraReports.UI.XtraReport
    {
        public JCReport()
        {
            InitializeComponent();
        }

        private void xrSubreport2_BeforePrint(object sender, System.Drawing.Printing.PrintEventArgs e)
        {
            XRSubreport xrSubReport = (XRSubreport)sender;
            xrSubReport.ReportSource.Parameters["GenerateJobCardId"].Value = Convert.ToInt32(GetCurrentColumnValue("GenJobCardId"));
        }
    }
}
