using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Xml.Serialization;

namespace FullStackSQL.Host
{
    public class RequestHandler
    {
        private readonly string _connectionString;
        public RequestHandler(string connectionString = null)
        {
            try
            {
                _connectionString = connectionString ??
                    ConfigurationManager.ConnectionStrings["Database"].ConnectionString;
            }
            catch (Exception e)
            {
                throw new ConfigurationErrorsException(_connectionString, e);
            }
        }

        public string HandleRequest(Request request)
        {
            try
            {
                using (var conn = new SqlConnection(_connectionString))
                using (var command = new SqlCommand("Router", conn))
                {
                    var serializedRequest = SerializeRequest(request);
                    var responseParam = PrepareStoredProcedureCommand(command, serializedRequest);
                    ExecuteProcedure(conn, command);
                    return responseParam.Value.ToString();
                }
            }
            catch (Exception e)
            {
                return "Error: " + e;
            }
        }

        private static void ExecuteProcedure(SqlConnection conn, SqlCommand command)
        {
            conn.Open();
            command.ExecuteNonQuery();
            conn.Close();
        }

        private static string SerializeRequest(Request request)
        {
            using (var sw = new StringWriter())
            {
                var xs = new XmlSerializer(typeof(Request));
                xs.Serialize(sw, request);
                return sw.ToString();
            }
        }

        private static SqlParameter PrepareStoredProcedureCommand(SqlCommand command, string request)
        {

            command.CommandType = CommandType.StoredProcedure;
            var requestParameter = new SqlParameter("@request", SqlDbType.Xml)
            {
                Value = request
            };
            var responseParameter = new SqlParameter("@response", SqlDbType.Xml)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(requestParameter);
            command.Parameters.Add(responseParameter);
            return responseParameter;
        }
    }
}