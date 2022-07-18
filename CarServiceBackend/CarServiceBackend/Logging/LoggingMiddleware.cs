using CarServiceBackend.Auth;
using Newtonsoft.Json;
using System.Text;

namespace CarServiceBackend.Logging
{
    public class LoggingMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<LoggingMiddleware> _logger;

        public LoggingMiddleware(ILogger<LoggingMiddleware> logger, RequestDelegate next)
        {
            _next = next;
            _logger = logger;
        }

        public async Task Invoke(HttpContext context)
        {
            log4net.LogicalThreadContext.Properties["user"] = context.User.GetId();

            var bodyJson = "";
            context.Request.EnableBuffering();
            if (context.Request.Body.CanSeek)
            {
                context.Request.Body.Seek(0, SeekOrigin.Begin);
                using (var reader = new StreamReader(
                     context.Request.Body,
                     encoding: Encoding.UTF8,
                     detectEncodingFromByteOrderMarks: false,
                     bufferSize: 8192,
                     leaveOpen: true))
                {
                    bodyJson = await reader.ReadToEndAsync();
                }
                context.Request.Body.Seek(0, SeekOrigin.Begin);
            }

            _logger.LogInformation($"METHOD:{context.Request.Method}\nPATH:{context.Request.Path}\nQUERY:{JsonConvert.SerializeObject(context.Request.Query.ToList())}\nBODY:{bodyJson}");
            await _next(context);
            log4net.LogicalThreadContext.Properties["user"] = null;
        }
    }
    
    public static class LoggingWiddlewareExtension
    {
        public static IApplicationBuilder UseUserLoggingContext(this IApplicationBuilder builder)
        {
            builder.UseMiddleware<LoggingMiddleware>();
            return builder;
        }
    }
}
