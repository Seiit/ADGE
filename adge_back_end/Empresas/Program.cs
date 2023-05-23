using Adge.Data;
using Adge.Data.Repositories;
using Adge.Data.Repositories.empresa;
using Adge.Data.Repositories.rol;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using WatchDog;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddWatchDogServices();

var sqlServerConfig = new SqlServerConfig(builder.Configuration.GetConnectionString("dbServer"));

builder.Services.AddSingleton<SqlServerConfig>(sqlServerConfig);

builder.Services.AddScoped<IEmpresaRepository,EmpresaRepository>();

builder.Services.AddScoped<IEventoRepository, EventoRepository>();

builder.Services.AddScoped<ICalendarioRepository, CalendarioRepository>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("NewPolicie", app =>
    {
        app.AllowAnyOrigin();
        app.AllowAnyHeader();
        app.AllowAnyMethod();
    });
});

builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
        .AddJwtBearer(options =>
        {
            options.RequireHttpsMetadata = false;
            options.SaveToken = true;
            options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"])),
                ValidateIssuer = false,
                ValidateAudience = false
            };
        });


var app = builder.Build();

app.UseWatchDogExceptionLogger();

app.UseWatchDog(configuration =>
{
    configuration.WatchPageUsername = "admin";
    configuration.WatchPagePassword = "admin";
});

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}



app.UseHttpLogging();

app.UseCors("NewPolicie");

app.UseHttpsRedirection();

app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
