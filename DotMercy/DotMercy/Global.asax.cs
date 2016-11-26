using DotWeb;
using DotWeb.Utils;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace DotMercy {
    public class Global_asax : System.Web.HttpApplication {
        void Application_Start(object sender, EventArgs e)
        {
            DevExpress.Web.ASPxWebControl.CallbackError += new EventHandler(Application_Error);
            RegisterRoutes(RouteTable.Routes);
            InspectSchema();
        }

        void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("list",
                "{module}/list", "~/dynamic/list.aspx");
            routes.MapPageRoute("edit",
                "{module}/edit/{values}", "~/dynamic/edit.aspx");
            routes.MapPageRoute("view",
                "{module}/view/{values}", "~/dynamic/edit.aspx");
        }

        void InspectSchema()
        {
            var dbInspector = new DbInspector();
            dbInspector.LoadFromConfig();
            if (dbInspector.SchemaInfo.Tables.Count == 0)
            {
                dbInspector.GenerateFromDb("AppDb");
            }

            Application["SchemaInfo"] = dbInspector.SchemaInfo;
        }

        void Application_End(object sender, EventArgs e) {
            // Code that runs on application shutdown
        }

        void Application_Error(object sender, EventArgs e) {
            // Code that runs when an unhandled error occurs
        }

        void Application_PostAcquireRequestState(object sender, EventArgs e)
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated || HttpContext.Current.Session == null) return;

            //var user = UserManager.FindByName(HttpContext.Current.User.Identity.Name);
            var user = HttpContext.Current.Session["user"] as User;
            if (user != null)
            {
                var sessionName = string.Format("accessRights_{0}_{1}", user.UserName, HttpContext.Current.Request.RawUrl);
                List<PermissionType> permissions = new List<PermissionType>();
                if (HttpContext.Current.Session[sessionName] == null)
                {
                    permissions = Helper.GetPermissions(user, HttpContext.Current.Request.RawUrl, 3);
                    HttpContext.Current.Session[sessionName] = permissions;
                }
                else
                    permissions = HttpContext.Current.Session[sessionName] as List<PermissionType>;

                // if no access rights were configured or if there is a "no access" permission, authorization should not be granted
                if (permissions.Count == 0 || permissions.Contains(PermissionType.NoAccess))
                    Response.Redirect("~/401.aspx");
            }
        }

        void Session_Start(object sender, EventArgs e) {
            if (HttpContext.Current.User.Identity.IsAuthenticated && HttpContext.Current.Session["user"] == null)
            {
                using (var appContext = new DotWebDb())
                {
                    var appUser = appContext.Users.SingleOrDefault(u => u.UserName.Equals(HttpContext.Current.User.Identity.Name, StringComparison.InvariantCultureIgnoreCase));
                    if (appUser != null)
                    {
                        Session["user"] = appUser;
                    }
                }
            }
        }

        void Session_End(object sender, EventArgs e) {
            // Code that runs when a session ends. 
            // Note: The Session_End event is raised only when the sessionstate mode
            // is set to InProc in the Web.config file. If session mode is set to StateServer 
            // or SQLServer, the event is not raised.
        }
    }
}