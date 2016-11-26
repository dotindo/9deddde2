using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DotMercy.custom.Report
{

    public partial class ReportJC : System.Web.UI.Page
    {      
        protected void Page_Load(object sender, EventArgs e)
        {
            ASPxDocumentViewer1.Report = CreateReport();
        }

        JCReport CreateReport()
        {
            JCReport report = new JCReport();
            //report.
            report.CreateDocument(false);
             
            //report.ExportToPdf(@"D:\Marcedes Benz\SourceCode\CompiledApp\custom\FileUpload\201302\C205\C250\JobCard.pdf");
            return report;
        }
    }
}