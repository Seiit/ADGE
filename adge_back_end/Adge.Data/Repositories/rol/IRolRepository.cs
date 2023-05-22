using Adge.Model;

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
