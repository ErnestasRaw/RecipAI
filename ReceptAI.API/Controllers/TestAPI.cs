using Rystem.OpenAi;

namespace ReceptAi.Controllers
{
    public class TestAPI
    {
        private readonly IOpenAiFactory _openAiFactory;

        public TestAPI(IOpenAiFactory openAIService)
        {
            this._openAiFactory = openAIService;
        }

        public async Task<string> GetResponse(string prompt)
        {
            var openAiApi = _openAiFactory.Create("receptas");
            var results = await openAiApi.Completion
                .Request("Generate me a recipe that i could use if i only have bread 200g, pepperoni 100g, butter 100g, jalapeno 1, cheese 100g, ")
                .WithModel(TextModelType.CurieText)
                .WithTemperature(0.1)
                .SetMaxTokens(5)
                .ExecuteAsync();

            return results.Completions[0].Text;
        }
    }
}
