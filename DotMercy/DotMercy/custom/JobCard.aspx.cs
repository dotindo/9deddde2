using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DevExpress.Web;

namespace DotMercy.custom
{
    public partial class JobCard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            grid.DataBind();
            //Session["SessionId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }

        protected void JobCardGrid_DataSelect(object sender, EventArgs e)
        {
            Session["SessionJobCardId"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            Session["SessionJobCardId2"] = (sender as ASPxGridView).GetMasterRowKeyValue();
            //Session["SessionJobCardPcId3"] = (sender as ASPxGridView).GetMasterRowKeyValue();
        }


    }
}