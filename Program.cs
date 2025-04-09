var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.WebHost.UseUrls("http://0.0.0.0:8082");
var app = builder.Build();

// Configure the HTTP request pipeline.

 app.UseSwagger();
 app.UseSwaggerUI(c =>
    {
        c.SwaggerEndpoint("/swagger/v1/swagger.json", "My API V1");
        c.RoutePrefix = string.Empty;  // This will set Swagger UI to be available at the root of the application.
    });

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
