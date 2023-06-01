using Adge.Model;
using Microsoft.Data.SqlClient;
using Microsoft.VisualBasic;
using Parametricas.Model.sistema;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public class EvidenciaRepository :IEvidenciaRepository
    {
        private readonly SqlServerConfig _sqlServerConfig;

        public EvidenciaRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }
        public async Task<dynamic?> CreateEvidencia(EvidenciaPgo evidencia) {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "INSERT INTO adge.evidencia (id_calendario_evento) VALUES(@id_calendario)";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_calendario", evidencia.id_calendario);

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
                        textoError = "No se pudo crear la evidencia"
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
                textoError = "No se pudo crear la evidencia"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }
        public async Task<dynamic?> GetEvidenciaById(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.evidencia ce inner join adge.calendario_evento e on ce.id_calendario_evento  = e.id_calendario_evento where ce.id_calendario_evento = @id_calendario_evento";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_calendario_evento", id);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {

                        var tesx = reader.IsDBNull(3) ? "" : reader.GetString(3);

                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Evidencia
                            {
                                id_evidencia = (int)reader.GetInt32(0),
                                idCalendario = (int)reader.GetInt32(1),
                                evidencia1 = reader.IsDBNull(2)?"": reader.GetString(2),
                                evidencia2 = reader.IsDBNull(3) ? "" : reader.GetString(3),
                                evidencia3 = reader.IsDBNull(4) ? "" : reader.GetString(4),
                                evidencia4 = reader.IsDBNull(5) ? "" : reader.GetString(5),
                            }
                        };
                    }
                }
                catch (Exception ex)
                {
                    dbErrors.Add(new DbError
                    {
                        autonumerado = 1,
                        parametro = "ui",
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
                textoError = "Evidencia no encontrada"
            });

            return new
            {
                success = false,
                message = "Evidencia no encontrada",
                result = dbErrors
            };
        }
        public async Task<dynamic> UpdateEvidencia1(String url, String id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.evidencia SET evidencia1 = @evidencia  WHERE id_calendario_evento = @id_evidencia";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@evidencia", url);
                cmd.Parameters.AddWithValue("@id_evidencia", id);

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
                        textoError = "No se pudo actualizar la evidencia"
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
                textoError = "No se pudo actualizar la evidencia"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }
        public async Task<dynamic> UpdateEvidencia2(String url, String id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.evidencia SET evidencia2 = @evidencia  WHERE id_calendario_evento = @id_evidencia";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@evidencia", url);
                cmd.Parameters.AddWithValue("@id_evidencia", id);

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
                        textoError = "No se pudo actualizar la evidencia"
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
                textoError = "No se pudo actualizar la evidencia"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }
        public async Task<dynamic> UpdateEvidencia3(String url, String id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.evidencia SET evidencia3 = @evidencia  WHERE id_calendario_evento = @id_evidencia";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@evidencia", url);
                cmd.Parameters.AddWithValue("@id_evidencia", id);

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
                        textoError = "No se pudo actualizar la evidencia"
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
                textoError = "No se pudo actualizar la evidencia"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }
        public async Task<dynamic> UpdateEvidencia4(String url, String id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.evidencia SET evidencia4 = @evidencia  WHERE id_calendario_evento = @id_evidencia";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@evidencia", url);
                cmd.Parameters.AddWithValue("@id_evidencia", id);

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
                        textoError = "No se pudo actualizar la evidencia"
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
                textoError = "No se pudo actualizar la evidencia"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }
    }
}
