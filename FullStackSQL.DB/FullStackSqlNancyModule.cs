namespace FullStackSQL.Framework
{
    public class FullStackSqlNancyModule : NancyModule
    {
        private readonly FullStackSqlApp _fullStackSqlApp;
        public FullStackSqlNancyModule()
        {
            _fullStackSqlApp = new FullStackSqlApp();
            //catch all routes
            Get["/"] = x => HandleRequest();
            Get["{uri*}"] = x => HandleRequest();
        }

        private string HandleRequest()
        {
            return _fullStackSqlApp.HandleRequest(MapRequest(this.Request));
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