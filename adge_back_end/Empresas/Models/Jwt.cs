using System.Security.Claims;

namespace Pararmetricas.Models
{
    public class Jwt
    {
        public string Key { get; set; }
        public string Issuer { get; set; }
        public string Audience { get; set;}
        public String Subjet { get; set; }

         public static dynamic validarToken(ClaimsIdentity identity)
        {
            try
            {
                if(identity.Claims.Count() == 0)
                {
                    return new
                    {
                        success = false,
                        message = "Vrifica si estas enviando un token",
                        result = ""
                    };
                }

                var id = identity.Claims.FirstOrDefault(x => x.Type == "name").ToString();

                if(id != "name: iam")
                {
                    return new
                    {
                        success = false,
                        message = "Contenido no autorizado",
                        result = id
                    };
                }

                return new
                {
                    success = true,
                    message = "Token leido",
                    result = id
                };
            }catch(Exception e)
            {
                return new
                {
                    success = false,
                    message = "Token leido",
                    result = e.Message
                };
                }
        }
    }

   
}
