using Adge.Model;
using Microsoft.Data.SqlClient;
using Parametricas.Model.sistema;

namespace Adge.Data.Repositories.empresa
{
    public class EmpresaRepository : IEmpresaRepository
    {
        
        private readonly SqlServerConfig _sqlServerConfig;

        public EmpresaRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }
        public async Task<dynamic> GetEmpresas()
        {
            List<Empresa> empresas = new List<Empresa>();

            var db = dbConection();

            db.Open();

            String sql = "select * from adge.empresa";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    empresas.Add(new Empresa
                    {
                        idEmpresa = (int) reader.GetInt32(0),
                        nombreEmpresa = reader.GetString(1),
                    });
                }
            }

            return new
            {
                success = true,
                message = "ok",
                result = new
                {
                    total = empresas.Count,
                    empresas = empresas
                }
            };
        }

        public async Task<dynamic> UpdateEmpresa(Empresa empresa)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.empresa WHERE nombre_empresa = @nombre_empresa and id_empresa != @id_empresa) BEGIN UPDATE adge.empresa SET nombre_empresa = @nombre_empresa WHERE id_empresa = @id_empresa END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_empresa", empresa.idEmpresa);
                cmd.Parameters.AddWithValue("@nombre_empresa", empresa.nombreEmpresa);

                try
                {
                    var result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = true
                        };
                    }
                }
                catch (Exception ex)
                {
                    dbErrors.Add(new DbError
                    {
                        autonumerado = 1,
                        parametro = "actualizacion",
                        textoError = "No se pudo actualizar la empresa"
                    });

                    return new
                    {
                        success = false,
                        message = "No hubo actualizacion",
                        result = dbErrors
                    };
                }
            }

            dbErrors.Add(new DbError
            {
                autonumerado = 1,
                parametro = "actualizacion",
                textoError = "No se pudo actualizar la empresa"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> DeleteEmpresa(int idEmpresa)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "delete adge.emrpesa where id_empresa = @id_rempresa ";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_empresa", idEmpresa);

                try
                {
                    var result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = true
                        };
                    }
                }
                catch (Exception ex)
                {
                    dbErrors.Add(new DbError
                    {
                        autonumerado = 1,
                        parametro = "eliminacion",
                        textoError = "No se pudo eliminar la empresa"
                    });

                    return new
                    {
                        success = false,
                        message = "No hubo eliminacion",
                        result = dbErrors
                    };
                }
            }

            dbErrors.Add(new DbError
            {
                autonumerado = 1,
                parametro = "eliminacion",
                textoError = "No se pudo eliminar la empresa"
            });

            return new
            {
                success = false,
                message = "No hubo eliminacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> CreateEmpresa(String nombreEmpresa)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.empresa WHERE nombre_empresa = @nombre_empresa) BEGIN INSERT INTO adge.empresa (nombre_empresa) VALUES(@nombre_empresa) END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@nombre_empresa", nombreEmpresa);

                try
                {
                    var result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = true
                        };
                    }
                }
                catch (Exception ex)
                {
                    dbErrors.Add(new DbError
                    {
                        autonumerado = 1,
                        parametro = "creacion",
                        textoError = "No se pudo crear la empresa"
                    });

                    return new
                    {
                        success = false,
                        message = "No hubo insercion",
                        result = dbErrors
                    };
                }
            }

            dbErrors.Add(new DbError
            {
                autonumerado = 1,
                parametro = "creacion",
                textoError = "No se pudo crear la empresa"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }

        public async Task<dynamic> GetEmpresaById(int idEmpresa)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.empresa where id_empresa = @id_empresa";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_empresa", idEmpresa);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Empresa
                            {
                                idEmpresa = reader.GetInt32(0),
                                nombreEmpresa = reader.GetString(1),
                            }
                        };
                    }
                }
                catch (Exception ex)
                {
                    dbErrors.Add(new DbError
                    {
                        autonumerado = 1,
                        parametro = "creacion",
                        textoError = "Error en la consulta"
                    });

                    return new
                    {
                        success = false,
                        message = "Error en la consulta",
                        result = dbErrors
                    };
                }
            }

            dbErrors.Add(new DbError
            {
                autonumerado = 1,
                parametro = "uid",
                textoError = "Empresa no encontrada"
            });

            return new
            {
                success = false,
                message = "Empresa no encontrada",
                result = dbErrors
            };
        }
    }
}
