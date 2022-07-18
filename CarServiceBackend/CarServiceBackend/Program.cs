using CarServiceBackend.Mapping;
using CarServiceBackend.Database;
using CarServiceBackend.GraphQL.Queries;
using CarServiceBackend.Logging;
using CarServiceBackend.Repository;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using FluentValidation;
using CarServiceBackend.GraphQL.Models.Validation;

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);

var builder = WebApplication.CreateBuilder(args);

builder.Configuration.AddEnvironmentVariables();

builder.Logging.ClearProviders();
if (builder.Environment.IsDevelopment()) {
    log4net.Util.LogLog.InternalDebugging = true;
}
builder.Logging.AddLog4Net();
PostgresLogger.Setup(builder.Configuration["DB_URL"]);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.Authority = builder.Configuration["JWT_AUTHORITY"];
        options.Audience = builder.Configuration["JWT_AUDIENCE"];
        options.RequireHttpsMetadata = false;
        options.IncludeErrorDetails = true;
        options.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters()
        {
            ValidateIssuer = false,
            ValidateIssuerSigningKey = false,
        };
    });
builder.Services.AddAuthorization();

builder.Services.AddDbContext<CarServiceContext>(options =>
    options.UseNpgsql(builder.Configuration["DB_URL"])
);

builder.Services.AddScoped<WorkRepository>();
builder.Services.AddScoped<TransportRepository>();
builder.Services.AddScoped<UserViewRepository>();

builder.Services.AddAutoMapper(typeof(TransportMappingProfile));
builder.Services.AddAutoMapper(typeof(WorkMappingProfile));

builder.Services.AddValidatorsFromAssemblyContaining<WorkAddViewValidator>();

builder.Services
    .AddGraphQLServer()
    .AddFairyBread()
    .AddAuthorization()
    .AddQueryType<Query>()
    .AddMutationType<Mutation>()
    .AddFiltering();

var app = builder.Build();



if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseGraphQLPlayground();
}
else
{
    app.UseExceptionHandler("/Home/Error");
}

app.UseStaticFiles();
app.UseHttpsRedirection();
app.UseRouting();
app.UseAuthentication();
app.UseAuthorization();
app.UseUserLoggingContext();

app.UseEndpoints(endpoints =>
{
    endpoints.MapGraphQL("/api");
});

app.Run();
