using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace ReceptAI.Core.Models
{
    public class Recipe
    {
        public int RecipeId { get; set; }
        public int UserId { get; set; }
        public string Name { get; set; }
        public string Instructions { get; set; }
        public List<Ingredient> Ingredients { get; set; } = new List<Ingredient>();
        
    }
}
