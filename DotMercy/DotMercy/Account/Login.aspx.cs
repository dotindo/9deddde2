using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Microsoft.AspNet.Identity.Owin;
using DotWeb;

namespace DotWeb_Samples {
    public partial class Login : System.Web.UI.Page {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (User.Identity.IsAuthenticated)
                {
                    //StatusText.Text = string.Format("Hello {0}!!", User.Identity.GetUserName());
                    //LoginStatus.Visible = true;
                    //LogoutButton.Visible = true;
                }
                else
                {
                    //LoginForm.Visible = true;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (var context = new IdentityDb())
            {
                var userStore = new UserStore<IdentityUser>(context);
                var userManager = new UserManager<IdentityUser>(userStore);
                var user = userManager.Find(tbUserName.Text, tbPassword.Text);

                if (user == null)
                {
                    lblError.Text = "Invalid username or password!";
                    divError.Attributes["class"] = "form-field visible";
                }
                else
                {
                    var authMgr = HttpContext.Current.GetOwinContext().Authentication;
                    var userIdentity = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
                    authMgr.SignIn(new AuthenticationProperties() { IsPersistent = false }, userIdentity);
                    using (var appContext = new DotWebDb())
                    {
                        var appUser = appContext.Users.SingleOrDefault(u => u.UserName.Equals(user.UserName, StringComparison.InvariantCultureIgnoreCase));
                        if (appUser != null)
                        {
                            Session["user"] = appUser;
                        }
                    }
                    Response.Redirect("~/");
                }
            }
        }
    }
}