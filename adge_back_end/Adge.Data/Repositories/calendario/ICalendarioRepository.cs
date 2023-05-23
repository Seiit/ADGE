using Adge.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public interface ICalendarioRepository
    {
        Task<dynamic> GetCalendarios();
        Task<dynamic?> CreateCalendario(CalendarioPgo evento);
        Task<dynamic?> GetCalendarioById(int id);
        Task<dynamic?> GetCalendariosByIdEvento(int id);
        Task<dynamic> UpdateCalendario(CalendarioPgo evento);
    }
}
