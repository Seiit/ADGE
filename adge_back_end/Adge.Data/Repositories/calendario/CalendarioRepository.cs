using Adge.Model;
using Microsoft.Data.SqlClient;
using Parametricas.Model.sistema;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public class CalendarioRepository : ICalendarioRepository
    {
        private readonly SqlServerConfig _sqlServerConfig;

        public CalendarioRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }
        public async Task<dynamic> GetCalendarios()
        {
            List<Calendario> calendarios = new List<Calendario>();

            var db = dbConection();

            db.Open();

            String sql = "select * from adge.calendario_evento ce inner join adge.evento e on ce.id_evento  = e.id_evento inner join adge.empresa e2 on e2.id_empresa = e.id_empresa ";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    calendarios.Add(new Calendario
                    {
                        idCalendario = (int)reader.GetInt32(0),
                        evento = new Evento
                        {
                            idEvento = (int)reader.GetInt32(1),
                            nombreEvento = reader.GetString(6),
                            empresa = new Empresa
                            {
                                idEmpresa = (int)reader.GetInt32(5),
                                nombreEmpresa = reader.GetString(8),
                            }
                        },
                        fechaInicio = reader.GetDateTime(2),
                        fechaFin = reader.GetDateTime(3)
                    });
                }
            }

            return new
            {
                success = true,
                message = "ok",
                result = new
                {
                    total = calendarios.Count,
                    calendarios = calendarios
                }
            };
        }

        public async Task<dynamic> CreateCalendario(CalendarioPgo calendario)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "INSERT INTO adge.calendario_evento (id_evento, fecha_inicio,fecha_fin) VALUES(@id_evento, @fecha_inicio,@fecha_fin)";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_evento", calendario.idEvento);
                cmd.Parameters.AddWithValue("@fecha_inicio", calendario.fechaInicio);
                cmd.Parameters.AddWithValue("@fecha_fin", calendario.fechaFin);

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
                        textoError = "No se pudo crear el calendario"
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
                textoError = "No se pudo crear el calendario"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }

        public async Task<dynamic> GetCalendarioById(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.calendario_evento ce inner join adge.evento e on ce.id_evento  = e.id_evento inner join adge.empresa e2 on e2.id_empresa = e.id_empresa where id_calendario_evento = @id_calendario_evento";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_calendario_evento", id);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Calendario
                            {
                                idCalendario = (int)reader.GetInt32(0),
                                evento = new Evento
                                {
                                    idEvento = (int)reader.GetInt32(1),
                                    nombreEvento = reader.GetString(6),
                                    empresa = new Empresa
                                    {
                                        idEmpresa = (int)reader.GetInt32(5),
                                        nombreEmpresa = reader.GetString(8)
                                    }
                                },
                                fechaInicio = reader.GetDateTime(2),
                                fechaFin = reader.GetDateTime(3)
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
                textoError = "Calendario no encontrado"
            });

            return new
            {
                success = false,
                message = "Calendario no encontrado",
                result = dbErrors
            };
        }

        public async Task<dynamic> UpdateCalendario(CalendarioPgo calendario)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.calendario_evento SET id_evento = @id_evento , fecha_inicio = @fecha_inicio, fecha_fin = @fecha_fin  WHERE id_calendario_evento = @id_calendario_evento";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_calendario_evento", calendario.idCalendario);
                cmd.Parameters.AddWithValue("@id_evento", calendario.idEvento);
                cmd.Parameters.AddWithValue("@fecha_inicio", calendario.fechaInicio);
                cmd.Parameters.AddWithValue("@fecha_fin", calendario.fechaFin);

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
                        textoError = "No se pudo actualizar el calendario"
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
                textoError = "No se pudo actualizar el calendario"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }
       
        public async Task<dynamic> GetCalendariosByIdEvento(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.calendario_evento ce inner join adge.evento e on ce.id_evento  = e.id_evento where id_calendario_evento = @id_calendario_evento";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_evento", id);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Calendario
                            {
                                idCalendario = (int)reader.GetInt32(0),
                                evento = new Evento
                                {
                                    idEvento = (int)reader.GetInt32(1),
                                    nombreEvento = reader.GetString(6),
                                    empresa = new Empresa
                                    {
                                        idEmpresa = (int)reader.GetInt32(5),
                                    }
                                },
                                fechaInicio = reader.GetDateTime(2),
                                fechaFin = reader.GetDateTime(3)
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
                textoError = "Calendario no encontrado"
            });

            return new
            {
                success = false,
                message = "Calendario no encontrado",
                result = dbErrors
            };
        }
    }
}
