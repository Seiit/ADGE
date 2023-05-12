using Adge.Data.Repositories;
using Adge.Data.Repositories.rol;
using Adge.Model;
using Microsoft.AspNetCore.Mvc;

namespace usuarios.Controllers
{
    [ApiController]
    [Route("Rol")]
    public class RolController
    {
        private readonly IRolRepository _rolRepository;

        public RolController(IRolRepository rolRepository)
        {
            _rolRepository = rolRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetRoles()
        {
            return _rolRepository.GetRoles();
        }

        [HttpGet]
        [Route("rol")]
        public async Task<dynamic> GetRolByUid(int id)
        {
            return _rolRepository.GetRolById(id);
        }

        [HttpDelete]
        public async Task<dynamic> DeleteRolByUid(int id)
        {
            return _rolRepository.DeleteRol(id);
        }

        [HttpPost]
        public async Task<dynamic> PostRol([FromBody] Rol rol)
        {
            return _rolRepository.CreateRol(rol.rol);
        }

        [HttpPut]
        public async Task<dynamic> PutUsuario([FromBody] Rol rol)
        {
            return _rolRepository.UpdateRol(rol);
        }
    }
}
