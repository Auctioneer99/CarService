namespace CarServiceBackend.GraphQL.Models
{
    public class InvalidEntityException : Exception
    {
        public InvalidEntityException(string entityName) : base($"Невозможно найти связь к полю \'{entityName}\'")
        {
        }
    }
}
