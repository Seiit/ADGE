using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Model
{
    public class Calendario
    {
        public int idCalendario { get; set; }
        public Evento evento { get; set; }
        public DateTime fechaInicio { get; set; }
        public DateTime fechaFin { get; set; }
    }

    public class CalendarioPgo
    {
        public String idCalendario { get; set; }
        public String idEvento { get; set; }
        public String fechaInicio { get; set; }
        public String fechaFin { get; set; }
    }
}
