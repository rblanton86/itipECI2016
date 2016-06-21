using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(eciWEB2016.Startup))]
namespace eciWEB2016
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
