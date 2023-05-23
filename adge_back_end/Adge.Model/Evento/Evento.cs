using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Model
{
    public class Evento
    {
        public int idEvento { get; set; }
        public Empresa empresa { get; set; }
        public String nombreEvento { get; set; }
    }

    public class EventoPgo
    {
        public String idEvento { get; set; }
        public String IdEmpresa { get; set; }
        public String nombreEvento { get; set; }
    }
}
