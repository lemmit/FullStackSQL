﻿using Nancy;

namespace FullStackSQL.Host
{
    public class Request
    {
        public Url Url { get; set; }
        public string Method { get; set; }
        public string Body { get; set; }
        //...
    }
}
