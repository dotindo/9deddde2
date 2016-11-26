using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using DotWeb;

namespace DotWeb_Samples {
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCreateUser_Click(object sender, EventArgs e)
        {
            try 
            {
                using (var context = new IdentityDb())
                {
                    var userStore = new UserStore<IdentityUser>(context);
                    var userManager = new UserManager<IdentityUser>(userStore);

                    var user = new IdentityUser() { UserName = tbUserName.Text, Email = tbEmail.Text };
                    IdentityResult result = userManager.Create(user, tbPassword.Text);

                    if (result.Succeeded)
                    {
                        using (var appContext = new DotWebDb())
                        {
                            var appUser = new User() { Id = user.Id, Email = user.Email, FirstName = tbFirstName.Text, LastName = tbLastName.Text };
                            appContext.Users.Add(appUser);
                            appContext.SaveChanges();
                        }

                        Response.Redirect(Request.QueryString["ReturnUrl"] ?? "~/Account/RegisterSuccess.aspx");
                    }
                    else
                    {
                        lblError.Text = "";
                        foreach (var error in result.Errors)
                            lblError.Text += error;
                        divError.Attributes["class"] = "form-field visible";
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = ex.Message;
                divError.Attributes["class"] = "form-field visible";
            }
        }
    }
}