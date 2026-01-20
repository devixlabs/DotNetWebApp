using DotNetWebApp.Models.Generated;
using Microsoft.AspNetCore.Mvc;

namespace DotNetWebApp.Controllers
{

    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : GenericController<Product>
    {
        public ProductController(Data.AppDbContext context) : base(context)
        {
        }
    }
}
