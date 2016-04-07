using System;
using System.IO;

namespace FullStackSQL.Framework
{
    public class FullStackSqlApp
    {
        private readonly string _connectionString;
        public FullStackSqlApp(string connectionString = null)
        {
            _connectionString = connectionString ?? "Data Source=LEMM\\SQLEXPRESS;Initial Catalog=full_stack_db;Integrated Security=True";
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