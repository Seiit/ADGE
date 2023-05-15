using Adge.Data.Repositories;
using Adge.Data.Repositories.rol;
using Adge.Model;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Pararmetricas.Models;
using System.Security.Claims;

namespace usuarios.Controllers
{
    [ApiController]
    [Route("Rol")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class RolController :ControllerBase
    {
        private readonly IRolRepository _rolRepository;

        public RolController(IRolRepository rolRepository)
        {
            _rolRepository = rolRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetRoles()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _rolRepository.GetRoles();
        }

        [HttpGet]
        [Route("rol")]
        public async Task<dynamic> GetRolByUid(int id)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _rolRepository.GetRolById(id);
        }

        [HttpDelete]
        public async Task<dynamic> DeleteRolByUid(int id)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _rolRepository.DeleteRol(id);
        }

        [HttpPost]
        public async Task<dynamic> PostRol([FromBody] Rol rol)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _rolRepository.CreateRol(rol.rol);
        }

        [HttpPut]
        public async Task<dynamic> PutUsuario([FromBody] Rol rol)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _rolRepository.UpdateRol(rol);
        }
    }
}
