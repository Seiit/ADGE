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
    [Route("Calendario")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class CalendarioController : ControllerBase
    {
        private readonly ICalendarioRepository _calendarioRepository;

        public CalendarioController(ICalendarioRepository calendarioRepository)
        {
            _calendarioRepository = calendarioRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetCalendarios()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _calendarioRepository.GetCalendarios();
        }

        [HttpPost]
        public async Task<dynamic> PostCalendario([FromBody] CalendarioPgo calendario)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _calendarioRepository.CreateCalendario(calendario);
        }

        [HttpGet]
        [Route("calendario")]
        public async Task<dynamic> GetCalendarioById(int idCalendario)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _calendarioRepository.GetCalendarioById(idCalendario);
        }

        [HttpGet]
        [Route("evento")]
        public async Task<dynamic> GetCalendariosByIdEvento(int idEvento)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _calendarioRepository.GetCalendariosByIdEvento(idEvento);
        }

        [HttpPut]
        public async Task<dynamic> PutCalendario([FromBody] CalendarioPgo calendario)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _calendarioRepository.UpdateCalendario(calendario);
        }
    }
}
