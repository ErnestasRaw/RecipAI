using ReceptAi;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddScoped<IRecipeService, RecipeService>();
builder.Services.AddControllers();
builder.Services.AddOpenAi(settings =>
{
    settings.ApiKey = "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";
});
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();


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
