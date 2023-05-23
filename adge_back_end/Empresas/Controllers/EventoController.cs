using Adge.Data.Repositories;
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
    [Route("Evento")]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class EventoController : ControllerBase
    {
        private readonly IEventoRepository _eventoRepository;

        public EventoController(IEventoRepository eventoRepository)
        {
            _eventoRepository = eventoRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetEventos()
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _eventoRepository.GetEventos();
        }

        [HttpPost]
        public async Task<dynamic> PostEvento([FromBody] EventoPgo evento)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _eventoRepository.CreateEvento(evento);
        }

        [HttpGet]
        [Route("evento")]
        public async Task<dynamic> GetEventoById(int idEvento)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _eventoRepository.GetEventoById(idEvento);
        }

        [HttpPut]
        public async Task<dynamic> PutEvento([FromBody] EventoPgo evento)
        {
            var identity = HttpContext.User.Identity as ClaimsIdentity;

            var rtoken = Jwt.validarToken(identity);

            if (!rtoken.success) return rtoken;

            return _eventoRepository.UpdateEvento(evento);
        }
    }
}
