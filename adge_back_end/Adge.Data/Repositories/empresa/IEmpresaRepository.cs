using Adge.Model;

namespace Adge.Data.Repositories.empresa
{
    public interface IEmpresaRepository
    {
        Task<dynamic> GetEmpresas();

        Task<dynamic> UpdateEmpresa(Empresa empresa);

        Task<dynamic> DeleteEmpresa(int id);

        Task<dynamic?> GetEmpresaById(int id);

        Task<dynamic?> CreateEmpresa(String empresa);
    }
}
