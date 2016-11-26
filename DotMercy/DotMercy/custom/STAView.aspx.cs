using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

namespace DotMercy.custom
{
    public partial class STAView : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Session["sessiionRICId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void detailGrid_DataSelect(object sender, EventArgs e)
        {
            Session["sessiionRICId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["sessiionRICId2"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

    }
}