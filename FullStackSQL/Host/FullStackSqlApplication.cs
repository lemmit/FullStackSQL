using System;
using Nancy;
using Nancy.Hosting.Self;

namespace FullStackSQL.Host
{
    public class FullStackSqlApplication
    {
        public void HostApp()
        {
            using (var host = new NancyHost(
                new Uri("http://localhost:1234"),
                new DefaultNancyBootstrapper(),
                new HostConfiguration
                {
                    UrlReservations = new UrlReservations
                    {
                        CreateAutomatically = true
                    }
                }
                )
                )
            {
                host.Start();
                Console.WriteLine("Started...");
                Console.ReadLine();
            }
        }
    }
}