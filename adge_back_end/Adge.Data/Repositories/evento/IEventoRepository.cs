using Adge.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public interface IEventoRepository
    {
        Task<dynamic> GetEventos();
        Task<dynamic?> CreateEvento(EventoPgo evento);
        Task<dynamic?> GetEventoById(int id);
        Task<dynamic> UpdateEvento(EventoPgo evento);
    }
}
