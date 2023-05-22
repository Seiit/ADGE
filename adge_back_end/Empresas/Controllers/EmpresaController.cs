using Adge.Data.Repositories.empresa;
using Adge.Model;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Pararmetricas.Models;
using System.Security.Claims;

namespace empresas.Controllers
{
    [ApiController]
    [Route("Empresa")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class EmpresaController :ControllerBase
    {
        private readonly IEmpresaRepository _empresaRepository;

        public EmpresaController(IEmpresaRepository empresaRepository)
        {
            _empresaRepository = empresaRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetEmpresas()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _empresaRepository.GetEmpresas();
        }

        [HttpGet]
        [Route("empresa")]
        public async Task<dynamic> GetRolByUid(int idEmpresa)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _empresaRepository.GetEmpresaById(idEmpresa);
        }

        [HttpDelete]
        public async Task<dynamic> DeleteRolByUid(int idEmpresa)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _empresaRepository.DeleteEmpresa(idEmpresa);
        }

        [HttpPost]
        public async Task<dynamic> PostRol([FromBody] Empresa empresa)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _empresaRepository.CreateEmpresa(empresa.nombreEmpresa);
        }

        [HttpPut]
        public async Task<dynamic> PutRol([FromBody] Empresa empresa)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _empresaRepository.UpdateEmpresa(empresa);
        }
    }
}
