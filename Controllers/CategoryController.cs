using DotNetWebApp.Models.Generated;
using Microsoft.AspNetCore.Mvc;

namespace DotNetWebApp.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class CategoryController : GenericController<Category>
    {
        public CategoryController(Data.AppDbContext context) : base(context)
        {
        }
    }
}
