using Adge.Data.Repositories;
using Adge.Model;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Pararmetricas.Models;
using System.Security.Claims;

namespace usuarios.Controllers
{
    [ApiController]
    [Route("Usuario")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class UserController : ControllerBase
    {
        private readonly IUsuarioRepository _usuarioRepository;

        public UserController(IUsuarioRepository usuarioRepository)
        {
            _usuarioRepository = usuarioRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetUsuarios()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _usuarioRepository.GetUsers();
        }

        [HttpGet]
        [Route("user")]
        public async Task<dynamic> GetUsuariosImgByUid(string uid)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _usuarioRepository.GetUsersByUid(uid);
        }

        [HttpDelete]
        public async Task<dynamic> DeleteUsuariosByUid(string uid)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _usuarioRepository.DeleteUsers(uid);
        }

        [HttpPost]
        public async Task<dynamic> PostUsuario([FromBody] Usuario user)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _usuarioRepository.CreateUser(user);
        }

        [HttpPut]
        public async Task<dynamic> PutUsuario([FromBody] Usuario user)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _usuarioRepository.UpdateUsers(user);
        }

        [HttpPut]
        [Route("user")]
        public async Task<dynamic> PutUsuarioImg([FromBody] Usuario user)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _usuarioRepository.UpdateUsersImg(user);
        }

    }
}
