namespace CarServiceBackend.GraphQL.Models.Transport
{
    public class TransportAddView
    {
        public string Number { get; set; } = null!;
        public string Model { get; set; } = null!;
        public string OwnerId { get; set; } = null!;
    }
}
