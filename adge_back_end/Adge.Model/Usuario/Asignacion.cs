namespace Adge.Model
{
    public class Asignacion
    {
        public int idAsignacion { get; set; }
        public Usuario usuario { get; set; }
        public Empresa empresa { get; set; }
        public Rol rol { get; set; }
    }

    public class AsignacionPog
    {
        public String id_Asignacion { get; set; }
        public String id_usuario { get; set; }
        public String id_empresa { get; set; }
        public String id_rol { get; set; }
    }
}
