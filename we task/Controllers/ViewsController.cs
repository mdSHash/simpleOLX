using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using we_task.Models;

namespace we_task.Controllers
{
    public class ViewsController : Controller
    {
        taskEntities db = new taskEntities();
        Helpers help = new Helpers();
        public bool auth()
        {
                if (Session["id"] == null || Session["token"] == null)
                {
                    return false;
                }
                int id = int.Parse(Session["id"].ToString());
                string token = Convert.ToString(Session["token"]);
                    return help.ViewAuthenication(id, token);
        }
        // GET: Views
        public ActionResult Index()
        {
            if (Session["contact"] == null)
                return Redirect("/Views/contact");
            
            else if (auth() == true)
                return View();
            else
                return Redirect("/Views/login");
        }
        public ActionResult login()
        {
            if(Session["id"] != null)
            {
                int uid = int.Parse(Session["id"].ToString());
                Client c = db.Clients.Find(uid);
                if (c == null && c.token != Session["token"].ToString())
                {
                    return View();
                }
            }
            if (Session["id"] == null && Session["token"] == null && Session["contact"] == null )
                return View();
            else
                return Redirect("/");
        }
        public ActionResult Order()
        {
            if (auth() == true)
            {
                int uid = int.Parse(Session["id"].ToString());
                int contact = int.Parse(Session["contact"].ToString());
                Access ace = db.Accesses.Where(o => o.ClientID == uid && o.ContactNum.Value == contact).FirstOrDefault();
                ViewBag.data = ace;
                return View();
            }
            else
                return Redirect("/Views/login");
        }
        public ActionResult Features()
        {
            if (auth() == true)
                return View();
            else
                return Redirect("/Views/login");
        }
        public ActionResult contact()
        {
            if (auth() == true)
                return View();
            else
                return Redirect("/Views/login");
        }
    }
}