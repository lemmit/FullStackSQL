using System;

namespace FullStackSQL.Framework
{
    public class FullSqlApp
    {
    
        public static void HostApp()
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