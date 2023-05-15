using Adge.Model;
using Microsoft.Data.SqlClient;
using Parametricas.Model.sistema;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Adge.Data.Repositories.rol
{
    public class RolRepository : IRolRepository
    {
        private readonly SqlServerConfig _sqlServerConfig;

        public RolRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }
        public async Task<dynamic> GetRoles()
        {
            List<Rol> roles = new List<Rol>();

            var db = dbConection();

            db.Open();

            String sql = "select * from adge.rol";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    roles.Add(new Rol
                    {
                        id = (int) reader.GetInt32(0),
                        rol = reader.GetString(1),
                    });
                }
            }

            return new
            {
                success = true,
                message = "ok",
                result = new
                {
                    total = roles.Count,
                    roles = roles
                }
            };
        }

        public async Task<dynamic> UpdateRol(Rol rol)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.rol WHERE rol = @rol and id_rol != @id_rol) BEGIN UPDATE adge.rol SET rol= @rol, valor_calificacion=0 WHERE id_rol= @id_rol END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_rol", rol.id);
                cmd.Parameters.AddWithValue("@rol", rol.rol);

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
                        textoError = "No se pudo actualizar el rol"
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
                textoError = "No se pudo actualizar el rol"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> DeleteRol(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "delete adge.rol where id_rol = @id_rol ";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_rol", id);

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
                        textoError = "No se pudo eliminar el rol"
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
                textoError = "No se pudo eliminar el rol"
            });

            return new
            {
                success = false,
                message = "No hubo eliminacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> CreateRol(String rol)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.rol WHERE rol = @rol) BEGIN INSERT INTO adge.rol (rol, valor_calificacion) VALUES(@rol, 0) END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@rol", rol);

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
                        textoError = "No se pudo crear el rol"
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
                textoError = "No se pudo crear el rol"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }

        public async Task<dynamic> GetRolById(int id)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.rol where id_rol = @id_rol";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_rol", id);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Rol
                            {
                                id = reader.GetInt32(0),
                                rol = reader.GetString(1),
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
