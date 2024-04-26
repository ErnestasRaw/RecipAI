using Microsoft.AspNetCore.Hosting.Server;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using ReceptAI.Core.Interfaces;
using ReceptAI.Infrastructure;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IRecipeService, RecipeService>();
builder.Services.AddScoped<IRecipeRepository, RecipeRepository>();
builder.Services.AddScoped<IUserRepository, UserRepository>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddControllers();
builder.Services.AddOpenAi(settings =>
{
    settings.ApiKey = "sk-proj-wBoeu8ngNKnLNnbJ3uELT3BlbkFJgLrV8nL7SB18tolKwfTc";
});
builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseMySql(@"server = localhost; port = 3306; database = receptaidb; username = root;",
        new MySqlServerVersion(new Version(10, 4, 28)));
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.SwaggerDoc("v1", new OpenApiInfo { Title = "ReceptAI", Version = "v1" });
    c.EnableAnnotations(); 
});


var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
