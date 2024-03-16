using Newtonsoft.Json;

namespace ReceptAI.Core.Models
{
    public class Ingredient
    {
        public int IngredientId { get; set; }
        public string Name { get; set; }
        public string Quantity { get; set; }
    }
}
