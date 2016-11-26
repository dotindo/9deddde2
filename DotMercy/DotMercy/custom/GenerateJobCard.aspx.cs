using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

namespace DotMercy.custom
{
    public partial class GenerateJobCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            grid.DataBind();
            //Session["SessionId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }


    }
}