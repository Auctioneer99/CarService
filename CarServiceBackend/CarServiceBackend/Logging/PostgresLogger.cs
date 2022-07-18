using log4net;
using log4net.Appender;
using log4net.Core;
using log4net.Layout;
using log4net.Repository.Hierarchy;
using System.Data;

namespace CarServiceBackend.Logging
{
    public class PostgresLogger
    {
        public static void Setup(string connectionString)
        {
            Hierarchy hierarchy = (Hierarchy)LogManager.GetRepository();

			var converter = new RawLayoutConverter();
			PostgresAppender postgres = new PostgresAppender();
			postgres.Threshold = Level.Info;
			postgres.BufferSize = 1;
			postgres.ConnectionType = "Npgsql.NpgsqlConnection, Npgsql";
			postgres.ConnectionString = connectionString;
			postgres.ReconnectOnError = true;
			postgres.UseTransactions = false;
			postgres.CommandText = "INSERT INTO Logs (date,thread,level,logger,log_user,message,error) VALUES (NOW(), @thread, @log_level, @logger, @user, @message, @error)";
			postgres.AddParameter(new AdoNetAppenderParameter()
				{ ParameterName = "@thread", DbType = DbType.String, Size = 255, Layout = (IRawLayout)converter.ConvertFrom(new PatternLayout("%thread")) });
			postgres.AddParameter(new AdoNetAppenderParameter()
				{ ParameterName = "@log_level", DbType = DbType.String, Size = 20, Layout = (IRawLayout)converter.ConvertFrom(new PatternLayout("%level")) });
			postgres.AddParameter(new AdoNetAppenderParameter()
				{ ParameterName = "@logger", DbType = DbType.String, Size = 255, Layout = (IRawLayout)converter.ConvertFrom(new PatternLayout("%logger")) });
			postgres.AddParameter(new AdoNetAppenderParameter()
				{ ParameterName = "@user", DbType = DbType.String, Size = 255, Layout = (IRawLayout)converter.ConvertFrom(new PatternLayout("%property{user}")) });
			postgres.AddParameter(new AdoNetAppenderParameter()
				{ ParameterName = "@message", DbType = DbType.String, Size = 4000, Layout = (IRawLayout)converter.ConvertFrom(new PatternLayout("%message")) });
			postgres.AddParameter(new AdoNetAppenderParameter()
				{ ParameterName = "@error", DbType = DbType.String, Size = 2000, Layout = (IRawLayout)converter.ConvertFrom(new ExceptionLayout()) });

			postgres.ActivateOptions();

            hierarchy.Root.AddAppender(postgres);

            //hierarchy.Root.Level = Level.Info;
            //hierarchy.Configured = true;
        }
    }
}