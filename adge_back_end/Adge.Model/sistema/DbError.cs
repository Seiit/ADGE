using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Parametricas.Model.sistema
{
    public class DbError {
        public int? autonumerado { get; set; }
        public string? proceso { get; set; }
        public string? subproceso { get; set; }
        public string? parametro { get; set; }
        public string? textoError { get; set; }
        public string? TipoError { get; set; }
    }
}
