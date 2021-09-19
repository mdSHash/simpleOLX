using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using we_task.Models;
namespace we_task
{
    public class Helpers
    {
        taskEntities db = new taskEntities();
        public bool ViewAuthenication(int id, string token)
        {
            try
            {
                    Client c = db.Clients.Find(id);
                    if (c != null)
                    {
                        if (c.token != token)
                        {
                            return false;
                        }
                        else
                            return true;
                    }
                return false;
            }
            catch (Exception)
            {
                throw;
            }
        }
        public bool Empty(string[] value)
        {
            foreach (var item in value)
            {
                if (string.IsNullOrWhiteSpace(item) || string.IsNullOrEmpty(item))
                {
                    return true;
                }
            }
            return false;
        }
        public bool LoginAuth(string username, string password)
        {
            string[] val = {username, password};
            if (!Empty(val))
            {
                Client c = db.Clients.Where(o => o.username == username).FirstOrDefault();
                if (c != null)
                {
                    if (c.username != username || c.password != password)
                    {
                        return false;
                    }
                    else
                        return true;
                }
            }
            return false;
        }
        public string[] ClientSession(string username)
        {
            string[] val = { username };
            if(!Empty(val))
            {
                Client c = db.Clients.Where(o => o.username == username).FirstOrDefault();
                if (c != null)
                {
                    string[] info = { c.id.ToString(), c.token };
                    return info;
                }
            }
            string[] info1 = {"duh"};
            return info1;
        }
    }
}