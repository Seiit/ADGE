using Adge.Data.Repositories;
using Adge.Model;
using Microsoft.AspNetCore.Mvc;

namespace usuarios.Controllers
{
    [ApiController]
    [Route("Register")]
    public class RegisterController
    {
        private readonly IUsuarioRepository _usuarioRepository;

        public RegisterController(IUsuarioRepository usuarioRepository)
        {
            _usuarioRepository = usuarioRepository;
        }
        [HttpPost]
        public async Task<dynamic> PostUsuario([FromBody] Usuario user)
        {
            return _usuarioRepository.CreateUser(user);
        }
    }
}
