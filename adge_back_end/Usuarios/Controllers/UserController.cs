using Adge.Data.Repositories;
using Adge.Model;
using Microsoft.AspNetCore.Mvc;
using System.Text.Json.Nodes;

namespace usuarios.Controllers
{
    [ApiController]
    [Route("Usuario")]
    public class UserController
    {
        private readonly IUsuarioRepository _usuarioRepository;

        public UserController(IUsuarioRepository usuarioRepository)
        {
            _usuarioRepository = usuarioRepository;
        }

        [HttpGet]
        public async Task<dynamic> GetUsuarios()
        {
            return _usuarioRepository.GetUsers();
        }

        [HttpGet]
        [Route("user")]
        public async Task<dynamic> GetUsuariosByUid(string uid)
        {
            return _usuarioRepository.GetUsersByUid(uid);
        }

        [HttpDelete]
        public async Task<dynamic> DeleteUsuariosByUid(string uid)
        {
            return _usuarioRepository.DeleteUsers(uid);
        }

        [HttpPost]
        public async Task<dynamic> PostUsuario([FromBody] Usuario user)
        {
            return _usuarioRepository.CreateUser(user);
        }

        [HttpPut]
        public async Task<dynamic> PutUsuario([FromBody] Usuario user)
        {
            return _usuarioRepository.UpdateUsers(user);
        }

        [HttpPut]
        [Route("user")]
        public async Task<dynamic> CargarArchivo(IFormFile archivo)
        {
            // Aquí puedes trabajar con el archivo recibido, por ejemplo, guardarlo en disco o en una base de datos
            // El archivo se encuentra en la variable "archivo", que es de tipo IFormFile

            // Ejemplo: guardar el archivo en disco
            using (var stream = new FileStream("ruta/del/archivo", FileMode.Create))
            {
                await archivo.CopyToAsync(stream);
            }

            return new { result = true};
        }
    }
}
