namespace CarServiceBackend.GraphQL.Models.Work
{
    public class WorkAddView
    {
        public long TransportId { get; set; }
        public DateTime PerformDate { get; set; }
        public DateTime? ReturnDate { get; set; }
        public double Price { get; set; }
        public double Mileage { get; set; }
        public string Task { get; set; } = null!;
    }
}
