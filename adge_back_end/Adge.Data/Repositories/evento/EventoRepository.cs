using Adge.Model;
using Microsoft.Data.SqlClient;
using Parametricas.Model.sistema;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories
{
    public class EventoRepository : IEventoRepository
    {
        private readonly SqlServerConfig _sqlServerConfig;

        public EventoRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }
        public async Task<dynamic> GetEventos()
        {
            List<Evento> eventos = new List<Evento>();

            var db = dbConection();

            db.Open();

            String sql = "select * from adge.evento ev inner join adge.empresa e on ev.id_empresa  = e.id_empresa";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    eventos.Add(new Evento
                    {
                        idEvento = (int)reader.GetInt32(0),
                        empresa = new Empresa
                        {
                            idEmpresa = (int)reader.GetInt32(1),
                            nombreEmpresa = reader.GetString(4),
                        },
                        nombreEvento = reader.GetString(2)
                    });
                }
            }

            return new
            {
                success = true,
                message = "ok",
                result = new
                {
                    total = eventos.Count,
                    eventos = eventos
                }
            };
        }

        public async Task<dynamic> CreateEvento(EventoPgo evento)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "INSERT INTO adge.evento(id_empresa, nombre_evento) VALUES(@id_empresa, @nombre_evento)";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_empresa", evento.IdEmpresa);
                cmd.Parameters.AddWithValue("@nombre_evento", evento.nombreEvento);

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
                        textoError = "No se pudo crear el evento"
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
                textoError = "No se pudo crear el evento"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }

        public async Task<dynamic> GetEventoById(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.evento ev inner join adge.empresa e on ev.id_empresa  = e.id_empresa where id_evento = @id_evento";

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
                            result = new Evento
                            {
                                idEvento = (int)reader.GetInt32(0),
                                empresa = new Empresa
                                {
                                    idEmpresa = (int)reader.GetInt32(1),
                                    nombreEmpresa = reader.GetString(4),
                                },
                                nombreEvento = reader.GetString(2)
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
                textoError = "Evento no encontrado"
            });

            return new
            {
                success = false,
                message = "Evento no encontrado",
                result = dbErrors
            };
        }

        public async Task<dynamic> UpdateEvento(EventoPgo evento)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.evento SET id_empresa = @id_empresa , nombre_evento = @nombre_evento WHERE id_evento = @id_evento";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_evento", evento.idEvento);
                cmd.Parameters.AddWithValue("@id_empresa", evento.IdEmpresa);
                cmd.Parameters.AddWithValue("@nombre_evento", evento.nombreEvento);

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
                        textoError = "No se pudo actualizar el evento"
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
                textoError = "No se pudo actualizar el evento"
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
