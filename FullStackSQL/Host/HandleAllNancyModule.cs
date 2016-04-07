using Nancy;
using Nancy.Extensions;
using Request = FullStackSQL.Host.Request;

namespace FullStackSQL.Host
{
    public class HandleAllNancyModule : NancyModule
    {
        private readonly RequestHandler _requestHandler;
        public HandleAllNancyModule()
        {
            _requestHandler = new RequestHandler();
            //catch all routes
            Get["/"] = x => HandleRequest();
            Get["{uri*}"] = x => HandleRequest();
        }

        private string HandleRequest()
        {
            return _requestHandler.HandleRequest(MapRequest(this.Request));
        }

        private Request MapRequest(Nancy.Request nancyRequest)
        {
            return new Request
            {
                Url = nancyRequest.Url,
                Body = nancyRequest.Body.AsString(),
                Method = nancyRequest.Method
            };
        }
    }
}