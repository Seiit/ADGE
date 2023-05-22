using Adge.Model;
using Microsoft.Data.SqlClient;
using Parametricas.Model;
using Parametricas.Model.sistema;

namespace Adge.Data.Repositories
{
    public class AsignacionRepository : IAsignacionRepository
    {
        private readonly SqlServerConfig _sqlServerConfig;

        public AsignacionRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }

        public async Task<dynamic> GetEmpresas()
        {
            var errors = new List<DbError>();
            var dropDataList = new List<DropData>();
            var db = dbConection();

            db.Open();

            string sql = "select null as codigo, 'Seleccione' as etiqueta union all select distinct convert(varchar(4000),[id_empresa]) as codigo, convert(varchar(4000),[nombre_empresa]) as etiqueta from [adge].[empresa] order by 1";

            await using (SqlCommand command = new SqlCommand(sql, db))
            {
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    
                    dropDataList.Add(new DropData
                        {
                            Codigo = reader.IsDBNull(0) ? "" : reader.GetString(0),
                            Etiqueta = reader.GetString(1)
                        });
                    
                }

                reader.Close();
            }

            db.Close();

            return new
            {
                success = true,
                message = "ok",
                result = dropDataList
            };
        }

        public async Task<dynamic> GetAsignaciones(String uid)
        {
            List<Asignacion> asignaciones = new List<Asignacion>();

            var db = dbConection();

            db.Open();

            String sql = "select asg.id_asignacion , usr.* , e.* , r.* from adge.asignaciones asg inner join adge.usuario usr on asg.id_usuario = usr.id_usuario inner join adge.empresa e on asg.id_empresa = e.id_empresa inner join adge.rol r on asg.id_rol = r.id_rol where asg.id_usuario = @id_usuario";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", uid);

                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    asignaciones.Add(new Asignacion
                    {
                        idAsignacion = (int) reader.GetInt32(0),
                        usuario = new Usuario
                        {
                            id = reader.GetString(1),
                            nombre = reader.GetString(2),
                            correo = reader.GetString(3),
                            img = reader.IsDBNull(4)?"": reader.GetString(4),
                        },
                        empresa = new Empresa
                        {
                            idEmpresa = (int) reader.GetInt32(5),
                            nombreEmpresa = reader.GetString(6),
                        },
                        rol = new Rol
                        {
                            id = (int) reader.GetInt32(7),
                            rol = reader.GetString(8),
                        },
                    });
                }
            }

            return new
            {
                success = true,
                message = "ok",
                result = new
                {
                    total = asignaciones.Count,
                    asignaciones = asignaciones
                }
            };
        }

        public async Task<dynamic> UpdateAsignacion(Asignacion asignacion)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.asignacion WHERE id_empresa != @id_empresa and id_rol != @id_rol and id_asignacion = @id_asignacion ) BEGIN UPDATE adge.asignacion SET id_empresa = @id_empresa , id_rol = @id_rol WHERE id_asignacion = @id_asignacion END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_asignacion", asignacion.idAsignacion);
                cmd.Parameters.AddWithValue("@id_rol", asignacion.rol.id);
                cmd.Parameters.AddWithValue("@id_empresa", asignacion.empresa.idEmpresa);

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
                        textoError = "No se pudo actualizar la asignacion"
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
                textoError = "No se pudo actualizar la asignacion"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> DeleteAsignacion(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "delete adge.asignacion where id_asignacion = @id_asignacion ";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_asignacion", id);

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
                        textoError = "No se pudo eliminar la asignacion"
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
                textoError = "No se pudo eliminar la asignacion"
            });

            return new
            {
                success = false,
                message = "No hubo eliminacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> CreateAsignacion(Asignacion asignacion)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.asignacion WHERE id_empresa != @id_empresa and id_rol != @id_rol and id_usuario = @id_usuario) BEGIN INSERT INTO adge.asignacion (id_usuario, id_empresa , id_rol) VALUES(@id_usuario, @id_empresa , @id_rol) END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", asignacion.usuario.id);
                cmd.Parameters.AddWithValue("@id_empresa", asignacion.empresa.idEmpresa);
                cmd.Parameters.AddWithValue("@id_rol", asignacion.rol.id);

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
                        textoError = "No se pudo crear la asignacion"
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
                textoError = "No se pudo crear la asignacion"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }

        public async Task<dynamic> GetAsignacionById(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select asg.id_asignacion , usr.* , e.* , r.* from adge.asignaciones asg inner join adge.usuario usr on asg.id_usuario = usr.id_usuario inner join adge.empresa e on asg.id_empresa = e.id_empresa inner join adge.rol r on asg.id_rol = r.id_rol where id_asignacion = @id_asignacion";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_asignacion", id);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Asignacion
                            {
                                idAsignacion = (int)reader.GetInt32(0),
                                usuario = new Usuario
                                {
                                    id = reader.GetString(1),
                                    nombre = reader.GetString(2),
                                    correo = reader.GetString(3),
                                    img = reader.IsDBNull(4) ? "" : reader.GetString(4),
                                },
                                empresa = new Empresa
                                {
                                    idEmpresa = (int)reader.GetInt32(5),
                                    nombreEmpresa = reader.GetString(6),
                                },
                                rol = new Rol
                                {
                                    id = (int)reader.GetInt32(7),
                                    rol = reader.GetString(8),
                                },
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
                textoError = "Rol no encontrado"
            });

            return new
            {
                success = false,
                message = "Rol no encontrado",
                result = dbErrors
            };
        }
    }
}
