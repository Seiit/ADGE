using Adge.Data.Repositories;
using Adge.Model;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Pararmetricas.Models;
using System.Security.Claims;

namespace empresas.Controllers
{
    [ApiController]
    [Route("Evidencia")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class EvidenciaController : ControllerBase
    {
        private readonly IEvidenciaRepository _evidenciaRepository;

        public EvidenciaController(IEvidenciaRepository evidenciaRepository)
        {
            _evidenciaRepository = evidenciaRepository;
        }

        [HttpPost]
        public async Task<dynamic> PostEvidencia([FromBody] EvidenciaPgo evidencia)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _evidenciaRepository.CreateEvidencia(evidencia);
        }

        [HttpGet]
        [Route("evidencia")]
        public async Task<dynamic> GetEvidenciaById(int idEvidencia)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _evidenciaRepository.GetEvidenciaById(idEvidencia);
        }

        [HttpPut]
        [Route("evidencia1/1")]
        public async Task<dynamic> PutEvidencia1Img([FromBody] EvidenciaPgoI evidencia)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _evidenciaRepository.UpdateEvidencia1(evidencia.url, evidencia.id);
        }

        [HttpPut]
        [Route("evidencia2/2")]
        public async Task<dynamic> PutEvidencia2Img([FromBody] EvidenciaPgoI evidencia)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _evidenciaRepository.UpdateEvidencia2(evidencia.url, evidencia.id);
        }

        [HttpPut]
        [Route("evidencia3/3")]
        public async Task<dynamic> PutEvidencia3Img([FromBody] EvidenciaPgoI evidencia)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _evidenciaRepository.UpdateEvidencia3(evidencia.url, evidencia.id);
        }

        [HttpPut]
        [Route("evidencia4/4")]
        public async Task<dynamic> PutEvidencia4Img([FromBody] EvidenciaPgoI evidencia)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _evidenciaRepository.UpdateEvidencia4(evidencia.url, evidencia.id);
        }
    }
}
