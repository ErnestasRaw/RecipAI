using Microsoft.EntityFrameworkCore;
using ReceptAI.Core.Models;

namespace ReceptAI.Infrastructure
{
    public class AppDbContext: DbContext
    {
        public DbSet<Recipe> Recipes { get; set; }

        public DbSet<Ingredient> Ingredients { get; set; }

        public DbSet<User> Users { get; set; }

        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

		protected override void OnModelCreating(ModelBuilder modelBuilder)
		{
			base.OnModelCreating(modelBuilder);

			modelBuilder.Entity<Recipe>()
				.Property(r => r.Name)
				.IsRequired();

			modelBuilder.Entity<Ingredient>()
				.Property(i => i.Name)
				.IsRequired();

			modelBuilder.Entity<User>()
				.Property(u => u.Username)
				.IsRequired();
		}
	}
}
