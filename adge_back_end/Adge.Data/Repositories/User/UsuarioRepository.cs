using Microsoft.Data.SqlClient;
using Adge.Data;
using Parametricas.Model.sistema;
using System.Reflection.PortableExecutable;
using Adge;
using Adge.Model;

namespace Adge.Data.Repositories
{
    public class UsuarioRepository : IUsuarioRepository
    {
        private readonly SqlServerConfig _sqlServerConfig;

        public UsuarioRepository(SqlServerConfig connectionString)
        {
            _sqlServerConfig = connectionString;
        }

        protected SqlConnection dbConection()
        {
            return new SqlConnection(_sqlServerConfig.ConnectionString);
        }
        public async Task<dynamic> GetUsers()
        {
            List<Usuario> users = new List<Usuario>();

            var db = dbConection();

            db.Open();

            String sql = "select * from adge.usuario";

            await using (SqlCommand cmd = new SqlCommand(sql,db))
            {
                var reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    users.Add(new Usuario
                    {
                        id = reader.GetString(0),
                        nombre = reader.GetString(1),
                        correo = reader.GetString(2)
                    }); ;
                }
            }

            return new { 
                success = true,
                message = "ok",
                result = new
                {
                    total = users.Count,
                    usuarios = users
                }
            };
        }

        public async Task<dynamic> UpdateUsers(Usuario user)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.usuario WHERE correo = @correo and id_usuario != @id_usuario ) BEGIN UPDATE adge.usuario SET nombre= @nombre, correo= @correo WHERE id_usuario= @id_usuario END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", user.id);
                cmd.Parameters.AddWithValue("@nombre", user.nombre);
                cmd.Parameters.AddWithValue("@correo", user.correo);

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
                        textoError = "No se pudo actualizar el usuario"
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
                textoError = "No se pudo actualizar el usuario"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }
        public async Task<dynamic> UpdateUsersImg(Usuario user)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "UPDATE adge.usuario SET img= @img WHERE id_usuario= @id_usuario";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", user.id);
                cmd.Parameters.AddWithValue("@img", user.img);

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
                        textoError = "No se pudo actualizar el usuario"
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
                textoError = "No se pudo actualizar el usuario"
            });

            return new
            {
                success = false,
                message = "No hubo actualizacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> DeleteUsers(String uid)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "delete adge.usuario where id_usuario = @id_usuario ";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", uid);

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
                        textoError = "No se pudo eliminar el usuario"
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
                textoError = "No se pudo eliminar el usuario"
            });

            return new
            {
                success = false,
                message = "No hubo eliminacion",
                result = dbErrors
            };
        }

        public async Task<dynamic> CreateUser(Usuario user)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "IF NOT EXISTS (SELECT 1 FROM adge.usuario WHERE correo = @correo) BEGIN INSERT INTO adge.usuario(id_usuario, nombre, correo)VALUES(@id_usuario, @nombre, @correo) END";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", user.id);
                cmd.Parameters.AddWithValue("@nombre",user.nombre);
                cmd.Parameters.AddWithValue("@correo", user.correo);

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
                }catch (Exception ex)
                {
                    dbErrors.Add(new DbError
                    {
                        autonumerado = 1,
                        parametro = "creacion",
                        textoError = "No se pudo crear el usuario"
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
                textoError = "No se pudo crear el usuario"
            });

            return new
            {
                success = false,
                message = "No hubo insercion",
                result = dbErrors
            };
        }

        public async Task<dynamic> GetUsersByUid(string uid)
        {
            List<DbError> dbErrors = new List<DbError>();
            var db = dbConection();

            db.Open();

            String sql = "select * from adge.usuario where id_usuario = @id_usuario";

            await using (SqlCommand cmd = new SqlCommand(sql, db))
            {
                cmd.Parameters.AddWithValue("@id_usuario", uid);

                try
                {
                    var reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        return new
                        {
                            success = true,
                            message = "ok",
                            result = new Usuario
                            {
                                id = reader.GetString(0),
                                nombre = reader.GetString(1),
                                correo = reader.GetString(2),
                                img = reader.IsDBNull(3)? "": reader.GetString(3)
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
                textoError = "Usuario no encontrado"
            });

            return new
            {
                success = false,
                message = "Usuario no encontrado",
                result = dbErrors
            };
        }
    }
}
