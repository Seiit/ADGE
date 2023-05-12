using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data
{
    public class SqlServerConfig
    {
        public SqlServerConfig(String connectionString) {
            ConnectionString = connectionString;
        }

        public String ConnectionString { get; set; } 
    }
}
