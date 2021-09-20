using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
        [HttpPost]
        public async Task<ActionResult> Order(int? Quanttity, string type, int? service, string date, string Fid)
        {
            string[] validate = { type, service.Value.ToString(), Quanttity.Value.ToString(), date, Fid };
            bool val = help.Empty(validate);
            if (val == true)
            {
                return Json(new {code = 0});
            }
            string Fids = string.Empty; ;
            for (int i = 1; i < Fid.Length; i++)
            {
                Fids += '|' + Fid + '|';
            }
            int con = int.Parse(Session["contact"].ToString());
            int clientID = int.Parse(Session["id"].ToString());
            ServiceOrder so = new ServiceOrder();
            so.Ordertype = type;
            so.ServiceID = service.Value;
            so.quantity = Quanttity.Value;
            so.OrderDate = DateTime.Parse(date);
            so.FeatureID = Fids;
            so.ContactNum = con;
            so.ClientID = clientID;
            string tok = help.Token();
            so.Token = tok;
            db.ServiceOrders.Add(so);
            await db.SaveChangesAsync();
            return Json(new { code = 1, token = tok});
        }

    }
}