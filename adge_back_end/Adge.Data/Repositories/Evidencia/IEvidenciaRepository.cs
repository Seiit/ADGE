using Adge.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public interface IEvidenciaRepository
    {
        Task<dynamic?> CreateEvidencia(EvidenciaPgo evidencia);
        Task<dynamic?> GetEvidenciaById(int id);
        Task<dynamic> UpdateEvidencia1(String url,String id);
        Task<dynamic> UpdateEvidencia2(String url, String id);
        Task<dynamic> UpdateEvidencia3(String url, String id);
        Task<dynamic> UpdateEvidencia4(String url, String id);
    }
}
