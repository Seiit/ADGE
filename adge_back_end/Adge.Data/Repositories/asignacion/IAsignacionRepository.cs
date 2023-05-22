using Adge.Model;
using Parametricas.Model.sistema;
using Parametricas.Model;

namespace Adge.Data.Repositories
{
    public interface IAsignacionRepository
    {
        Task<dynamic> GetEmpresas();
        Task<dynamic> GetAsignaciones(String uid);

        Task<dynamic> UpdateAsignacion(Asignacion asignacion);

        Task<dynamic> DeleteAsignacion(int id);

        Task<dynamic?> GetAsignacionById(int id);

        Task<dynamic?> CreateAsignacion(Asignacion asignacion);
    }
}
