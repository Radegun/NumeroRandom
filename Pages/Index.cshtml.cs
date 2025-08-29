using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace RandomNumberApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly ILogger<IndexModel> _logger;

        public IndexModel(ILogger<IndexModel> logger)
        {
            _logger = logger;
        }

        [BindProperty]
        public int? RandomNumber { get; set; }

        public void OnGet()
        {
        }

        public void OnPost()
        {
            var random = new Random();
            RandomNumber = random.Next(1, 101); // 1 al 100
        }
    }
}