using DotWeb;
using System;
using System.Web;

namespace DotMercy {
    public partial class RootMaster : System.Web.UI.MasterPage {
        protected void Page_Load(object sender, EventArgs e) {
            appTitle.Text = (Application["schemaInfo"] as SchemaInfo).App.Name;
            ASPxLabel2.Text = DateTime.Now.Year + Server.HtmlDecode(" &copy; Copyright by [company name]");
        }

        protected void HeadLoginStatus_Click(object sender, EventArgs e)
        {
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            authenticationManager.SignOut();
            Response.Redirect("~/Account/Login.aspx");
        }
    }


}