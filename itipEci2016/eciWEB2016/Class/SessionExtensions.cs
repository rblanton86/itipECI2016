using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace eciWEB2016.Class
{
    public static class SessionExtensions
    {

        public static T GetDataFromSession<T>(this HttpSessionStateBase session, int ID)
        {
            return (T)session[ID];
        }


    }
}