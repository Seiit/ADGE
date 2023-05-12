using Adge.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories.rol
{
    public interface IRolRepository
    {
        Task<dynamic> GetRoles();

        Task<dynamic> UpdateRol(Rol rol);

        Task<dynamic> DeleteRol(int id);

        Task<dynamic?> GetRolById(int id);

        Task<dynamic?> CreateRol(String rol);
    }
}
