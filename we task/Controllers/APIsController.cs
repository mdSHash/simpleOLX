using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using we_task.Models;

namespace we_task.Controllers
{
    public class APIsController : Controller
    {
        Helpers help = new Helpers();
        taskEntities db = new taskEntities();
        // GET: APIs
        [HttpGet]
        public ActionResult login(string username, string password)
        {
            if(help.LoginAuth(username, password))
            {
               string[] val = help.ClientSession(username);
                Session["id"] = val[0];
                string id = val[0];
                int uid = int.Parse(val[0]);
                Access ace = db.Accesses.Where(o => o.ClientID == uid).FirstOrDefault();
                Session["token"] = val[1];
                
                return Json(new { code = 1 }, JsonRequestBehavior.AllowGet);
            }
            return Json(new { code = 0 }, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult search(string token)
        {
            int uid = int.Parse(Session["id"].ToString());
            Client c = db.Clients.Find(uid);
            if (token != null || c != null || Session["token"].ToString() == c.token)
            {
                ServiceOrder so = db.ServiceOrders.Where(o => o.Token == token).FirstOrDefault();
                if (so != null)
                {
                    string dis = so.OrderDate.ToString();
                    object temp = new
                    {
                        quantity = so.quantity,
                        Service = so.Service.name,
                        Feature = so.Feature.info,
                        Ordertype = so.Ordertype,
                        OrderDate = dis,
                        ContactNum = so.ContactNum
                    };
                    return Json(temp);
                }
            }
            return Json(new { code = 0 });
        }
        [HttpGet]
        public ActionResult SetContact(int id)
        {
            Session["contact"] = id;
            return Json(new { code = 1 },JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        public ActionResult getF(int id)
        {
            List<Feature> f = db.Features.Where(o => o.ServicesID == id).ToList();
            List<object> obj = new List<object>();
            foreach (Feature item in f)
            {
                object temp = new
                {
                    id = item.id,
                    info = item.info
                };
                if (!obj.Contains(temp))
                {
                    obj.Add(temp);
                }
            }
            return Json(obj);
        }
    }
}