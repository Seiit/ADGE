using Adge.Model;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public interface IUsuarioRepository
    {
        Task<dynamic> GetUsers();

        Task<dynamic> UpdateUsers(Usuario usuario);

        Task<dynamic> DeleteUsers(String uid);

        Task<dynamic?> GetUsersByUid(string uid);

        Task<dynamic?> CreateUser(Usuario user);

       // Task<dynamic> CargarArchivo(IFormFile archivo);
    }
}
