using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

namespace DotMercy.custom
{
    public partial class Station : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void RicDetailsGrid_DataSelect(object sender, EventArgs e)
        {
            //Session["VarianId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

    }
}