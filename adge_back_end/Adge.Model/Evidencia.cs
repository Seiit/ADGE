using Adge.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Model
{
    public class Evidencia
    {
        public int id_evidencia { get; set; }
        public int idCalendario { get; set; }
        public String evidencia1 { get; set; }
        public String evidencia2 { get; set; }
        public String evidencia3 { get; set; }
        public String evidencia4 { get; set; }
    }

    public class EvidenciaPgo
    {
        public String id_evidencia { get; set; }
        public String id_calendario { get; set; }
        public String evidencia1 { get; set; }
        public String evidencia2 { get; set; }
        public String evidencia3 { get; set; }
        public String evidencia4 { get; set; }
    }
    public class EvidenciaPgoI
    {
        public String id { get; set; }
        public String url { get; set; }
    }
}
