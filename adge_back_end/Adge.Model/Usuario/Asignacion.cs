namespace Adge.Model
{
    public class Asignacion
    {
        public int idAsignacion { get; set; }
        public Usuario usuario { get; set; }
        public Empresa empresa { get; set; }
        public Rol rol { get; set; }
    }
}
