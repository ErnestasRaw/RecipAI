using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace ReceptAi
{
    public class Recipe
    {
        [Key]
        public int RecipeId { get; set; }
        public string Name { get; set; }
        public string Instructions { get; set; }
        public List<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
    }
}
